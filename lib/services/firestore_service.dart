import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/producto.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Método para obtener los productos desde Firestore
  Future<List<Producto>> getProductos() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('productos').get();
      return querySnapshot.docs
          .map((doc) => Producto(
            id: doc.id,
            nombre: doc['nombre'],
            precio: doc['precio'],
            imagenURL: doc['imagenURL'],
            marca: doc['marca'],
          ))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
