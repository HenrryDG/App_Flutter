import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/producto.dart';
import '../providers/cart_provider.dart';
import 'snackbar.dart';
import '../screens/productDetail_screen.dart'; // Importa la nueva pantalla

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
      child: InkWell(
        onTap: () {
          // Navegar a la pantalla de detalles del producto
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(producto: producto),
            ),
          );
        },
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
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 150,
                  color: Colors.grey,
                ),
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
              child: Text(
                '${producto.categoria} - ${producto.genero}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black26,
                ),
              ),
            ),
            Expanded( // Añadido Expanded
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bs. ${producto.precio}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      onPressed: () {
                        carrito.adicionarItem(producto);

                        CustomSnackBar.showCustomSnackBar(
                          context,
                          '${producto.nombre} añadido al carrito',
                          onActionPressed: () {
                            Navigator.pushNamed(context, '/carrito');
                          },
                          icon: Icons.shopping_cart,
                          backgroundColor: Colors.indigo,
                          duration: const Duration(seconds: 3),
                        );
                      },
                      child: const Icon(
                        Icons.add_shopping_cart,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
