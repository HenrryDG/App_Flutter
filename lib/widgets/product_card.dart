import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/producto.dart';
import '../providers/cart_provider.dart';
import 'snackbar.dart'; // Asegúrate de que tienes el archivo de snackbar

class ProductCard extends StatelessWidget {
  final Producto producto;

  const ProductCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CartProvider>(context);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              producto.imagenURL,
              height: 150, // Establece una altura fija para la imagen
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              producto.nombre,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Para separar el precio y el botón
              children: [
                // Texto del precio
                Text(
                  'Bs. ${producto.precio}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple,
                  ),
                ),
                // Botón de añadir al carrito
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, // Color de fondo
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordes redondeados
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduce el tamaño del botón
                  ),
                  onPressed: () async {
                    // Simulamos un retraso para no bloquear la UI
                    //await Future.delayed(const Duration(milliseconds: 500)); // Retraso simulado

                    // Agregar el producto al carrito
                    carrito.adicionarItem(producto);

                    // Mostrar el CustomSnackBar
                    CustomSnackBar.showCustomSnackBar(
                      context,
                      '${producto.nombre} añadido al carrito',
                      onActionPressed: () {
                        Navigator.pushNamed(context, '/cart'); // Acción al hacer clic en 'Ver carrito'
                      },
                    );
                  },
                  child: const Icon(
                    Icons.add_shopping_cart, // Ícono del carrito de compras
                    size: 20, // Reduce el tamaño del ícono
                    color: Colors.white, // Color del ícono
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
