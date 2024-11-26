import 'package:carrito_compras/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titulo de la pantalla
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 40.0),
              child: Text(
                'Carrito de Compras',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
            // Lista de productos en el carrito
            Expanded(
              child: ListView(
                children: cart.items.values.map((producto) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        producto.nombre,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Cantidad: ${producto.cantidad}'),
                          if (producto.tallaSeleccionada.isNotEmpty)
                            Text(
                              'Talla: ${producto.tallaSeleccionada}',
                              style: const TextStyle(color: Colors.black54),
                            ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Bs. ${(double.parse(producto.precio) * producto.cantidad).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.add),
                            color: Colors.green,
                            onPressed: () {
                              cart.adicionarItem(producto, producto.tallaSeleccionada);
                            },
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            color: Colors.red,
                            onPressed: () {
                              cart.removerItem(producto.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Total y botón de pago
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: Bs. ${cart.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  // Mostrar el botón solo si el carrito tiene productos
                  if (cart.items.isNotEmpty) 
                    ElevatedButton(
                      onPressed: () async {
                        final venta = {
                          'productos': cart.items.values.map((producto) {
                            return {
                              'nombre': producto.nombre,
                              'cantidad': producto.cantidad,
                              'talla': producto.tallaSeleccionada,
                              'precio': double.parse(producto.precio),
                            };
                          }).toList(),
                          'fecha': Timestamp.now(),
                          'total': cart.totalAmount,
                        };

                        await FirestoreService().registrarVenta(venta);
                        cart.items.clear();
                        cart.notifyListeners();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Compra realizada con éxito'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Pagar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/ventas'); 
          }
          if (index == 1) {
            Navigator.pushNamed(context, '/inicio'); 
          }
        },
        items: const [
            BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Compras',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),

        ],
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
