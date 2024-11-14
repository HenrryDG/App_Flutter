import 'package:flutter/material.dart';
import '../models/producto.dart';

class CartProvider with ChangeNotifier {
  final Map<String, Producto> _items = {};

  Map<String, Producto> get items => _items;

  void adicionarItem(Producto producto) {
    if (_items.containsKey(producto.id)) {
      _items[producto.id]!.cantidad++;
    } else {
      _items[producto.id] = producto;
    }
    notifyListeners();
  }

  void removerItem(String productId) {
    final existingProduct = _items[productId];

    // Si el producto está en el carrito y tiene más de 1 unidad, resta 1
    if (existingProduct != null && existingProduct.cantidad > 1) {
      existingProduct.cantidad--;
    } else {
      // Si la cantidad es 1 o el producto no existe, elimina el producto
      _items.remove(productId);
    }

    notifyListeners();
  }

  double get totalAmount {
    return _items.values.fold(
        0.0, (sum, item) => sum + (double.parse(item.precio) * item.cantidad));
  }
}
