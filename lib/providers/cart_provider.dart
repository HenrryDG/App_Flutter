import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<String, Product> _items = {};

  Map<String, Product> get items => _items;

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.cantidad++;
    } else {
      _items[product.id] = product;
    }
    notifyListeners();
  }

  void removeItem(String productId) {
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
