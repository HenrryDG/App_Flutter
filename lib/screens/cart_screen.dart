import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Margen alrededor de la lista
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título con margen superior y alineado a la izquierda
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, top: 40.0), // Margen superior ajustado
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
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Bordes redondeados
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        producto.nombre,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Cantidad: ${producto.cantidad}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Bs. ${double.parse(producto.precio) * producto.cantidad}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Botón de añadir
                          IconButton(
                            icon: const Icon(Icons.add),
                            color: Colors.green,
                            onPressed: () {
                              cart.adicionarItem(producto);
                            },
                          ),
                          const SizedBox(width: 8),
                          // Botón de eliminar
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
                  ElevatedButton(
                    onPressed: () {
                      // Lógica de pago o confirmación
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo, // Color del botón
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
        currentIndex: 1,  // Asegura que la opción del carrito esté seleccionada
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/inicio'); // Va a la pantalla de inicio
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
        ],
        selectedItemColor: Colors.indigo, // Color del ítem seleccionado
        unselectedItemColor: Colors.black54, // Color del ítem no seleccionado
        showSelectedLabels: true, // Mostrar etiquetas de los íconos
        showUnselectedLabels: true, // Mostrar etiquetas de los íconos no seleccionados
      ),
    );
  }
}
