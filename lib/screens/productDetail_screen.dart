import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/producto.dart';
import '../widgets/snackbar.dart';
import '../widgets/etiqueta.dart'; // Importa el widget Etiqueta

class ProductDetailScreen extends StatefulWidget {
  final Producto producto;

  const ProductDetailScreen({super.key, required this.producto});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String tallaSeleccionada = '';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final producto = widget.producto;

    return Scaffold(
      appBar: AppBar(
        title: Text(producto.nombre, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Centrar la imagen
            Center(
              child: Image.network(
                producto.imagenURL,
                fit: BoxFit.cover,
                height: 300,
                width: 300,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              producto.nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0, // Espaciado horizontal
              runSpacing: 8.0, // Espaciado vertical
              children: [
                Etiqueta(texto: producto.marca),
                Etiqueta(texto: producto.categoria),
                Etiqueta(texto: producto.genero),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Precio: Bs. ${producto.precio}',
              style: const TextStyle(fontSize: 18, color: Colors.indigo),
            ),
            const SizedBox(height: 16),

            // Selección de talla
            const Text('Tallas disponibles:', style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: producto.tallas.map<Widget>((talla) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      tallaSeleccionada = talla.toString(); // Actualizar la talla seleccionada
                    });
                  },
                  child: Container(
                    width: 50,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: tallaSeleccionada == talla.toString() ? Colors.indigo : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Center(
                      child: Text(
                        talla.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: tallaSeleccionada == talla.toString() ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Botón de añadir al carrito
            ElevatedButton(
              onPressed: tallaSeleccionada.isNotEmpty
                  ? () {
                      cart.adicionarItem(producto, tallaSeleccionada);

                      // Mostrar un SnackBar
                      CustomSnackBar.showCustomSnackBar(
                        context,
                        'Producto añadido al carrito',
                        onActionPressed: () {
                          Navigator.pushNamed(context, '/carrito');
                        },
                        icon: Icons.shopping_cart,
                        backgroundColor: Colors.indigo,
                      );
                    }
                  : null, // Desactivar si no se seleccionó talla
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Añadir al carrito',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
