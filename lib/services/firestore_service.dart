
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/producto.dart';
import '../models/venta.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Método para obtener los productos desde Firestore
  Future<List<Producto>> getProductos() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('productos').orderBy('nombre').get(); // Obtener productos ordenados por nombre de forma descendente
      return querySnapshot.docs
          .map((doc) => Producto(
            id: doc.id,
            nombre: doc['nombre'],
            precio: doc['precio'],
            imagenURL: doc['imagenURL'],
            marca: doc['marca'],
            genero: doc['genero'], // Obtener género
            categoria: doc['categoria'], // Obtener categoría
            tallas: List<dynamic>.from(doc['tallas']), // Obtener tallas (puede ser lista de números o cadenas)
          ))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> registrarVenta(Map<String, dynamic> venta) async {
    try {
      await _db.collection('ventas').add(venta);
      print("Venta registrada con éxito");
    } catch (e) {
      print("Error al registrar la venta: $e");
    }
  }

  Future<List<Venta>> getVentas({DateTime? desde, DateTime? hasta, String? clienteId}) async {
  try {
    Query query = _db.collection('ventas').orderBy('fecha', descending: true);

    // Agregar filtros dinámicos según los parámetros
    if (desde != null) {
      query = query.where('fecha', isGreaterThanOrEqualTo: desde);
    }
    if (hasta != null) {
      query = query.where('fecha', isLessThanOrEqualTo: hasta);
    }
    if (clienteId != null) {
      query = query.where('clienteId', isEqualTo: clienteId);
    }

    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs
        .map((doc) => Venta.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print("Error al obtener ventas: $e");
    return [];
  }
}

}
