import 'package:flutter/material.dart';
import '../models/producto.dart';

class CartProvider with ChangeNotifier {
  final Map<String, Producto> _items = {};

  Map<String, Producto> get items => _items;

  void adicionarItem(Producto producto, String tallaSeleccionada) {
    if (_items.containsKey(producto.id)) {
      _items[producto.id]!.cantidad++;
      _items[producto.id]!.tallaSeleccionada = tallaSeleccionada; // Actualizar talla
    } else {
      producto.tallaSeleccionada = tallaSeleccionada; // Asignar la talla seleccionada
      _items[producto.id] = producto;
    }
    notifyListeners();
  }

  void removerItem(String productId) {
    final existingProduct = _items[productId];

    if (existingProduct != null && existingProduct.cantidad > 1) {
      existingProduct.cantidad--;
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }

  double get totalAmount {
    return _items.values.fold(
        0.0, (sum, item) => sum + (double.parse(item.precio) * item.cantidad));
  }
}
