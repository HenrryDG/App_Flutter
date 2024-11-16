import 'package:flutter/material.dart';
import '../models/producto.dart';


class ProductDetailScreen extends StatefulWidget {
  final Producto producto;

  const ProductDetailScreen({super.key, required this.producto});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? tallaSeleccionada;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.producto.nombre,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.producto.imagenURL,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              widget.producto.nombre,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Marca: ${widget.producto.marca}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(
              'Categoría: ${widget.producto.categoria}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(
              'Género: ${widget.producto.genero}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tallas disponibles:',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0, // Espacio horizontal entre los cuadros
              runSpacing: 8.0, // Espacio vertical entre las filas de cuadros
              children: widget.producto.tallas.map<Widget>((talla) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      tallaSeleccionada = talla.toString();
                    });
                  },
                  child: Container(
                    width: 50, // Ancho fijo para todos los cuadros
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: tallaSeleccionada == talla.toString()
                          ? Colors.indigo
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Center(
                      child: Text(
                        talla.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: tallaSeleccionada == talla.toString()
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
