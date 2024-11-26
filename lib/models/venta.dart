import 'package:cloud_firestore/cloud_firestore.dart';

class Venta {
  final List<ProductoVenta> productos;
  final DateTime fecha;
  final double total;

  Venta({
    required this.productos,
    required this.fecha,
    required this.total,
  });

  // Constructor para convertir los datos de Firebase en una instancia de Venta
  factory Venta.fromFirestore(Map<String, dynamic> data) {
    return Venta(
      productos: (data['productos'] as List<dynamic>)
          .map((item) => ProductoVenta.fromFirestore(item))
          .toList(),
      fecha: (data['fecha'] as Timestamp).toDate(),
      total: data['total'] as double,
    );
  }
}

class ProductoVenta {
  final String nombre;
  final int cantidad;
  final String talla;
  final double precio;

  ProductoVenta({
    required this.nombre,
    required this.cantidad,
    required this.talla,
    required this.precio,
  });

  // Constructor para convertir un producto de Firestore a ProductoVenta
  factory ProductoVenta.fromFirestore(Map<String, dynamic> data) {
    return ProductoVenta(
      nombre: data['nombre'] as String,
      cantidad: data['cantidad'] as int,
      talla: data['talla'] as String,
      precio: data['precio'] as double,
    );
  }
}
