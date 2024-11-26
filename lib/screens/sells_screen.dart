import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/venta.dart';

class VentasScreen extends StatefulWidget {
  const VentasScreen({super.key});

  @override
  _VentasScreenState createState() => _VentasScreenState();
}

class _VentasScreenState extends State<VentasScreen> {
  late Future<List<Venta>> _ventasFuture;

  @override
  void initState() {
    super.initState();
    _ventasFuture = FirestoreService().getVentas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la pantalla
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Text(
                'Compras Realizadas',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Venta>>(
                future: _ventasFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error al cargar las ventas'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No hay ventas registradas'));
                  } else {
                    final ventas = snapshot.data!;
                    return ListView.builder(
                      itemCount: ventas.length,
                      itemBuilder: (context, index) {
                        final venta = ventas[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ExpansionTile(
                            title: Text(
                              'Fecha: ${venta.fecha.toLocal()}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Total: \$${venta.total.toStringAsFixed(2)}'),
                            children: venta.productos.map((producto) {
                              return ListTile(
                                leading: const Icon(Icons.shopping_bag),
                                title: Text(producto.nombre),
                                subtitle: Text(
                                    'Cantidad: ${producto.cantidad} | Talla: ${producto.talla}'),
                                trailing: Text(
                                  '\$${producto.precio.toStringAsFixed(2)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 10,
        currentIndex: 0, // Índice de la pestaña activa, ajusta según sea necesario
        onTap: (int index) {
          // Agrega tu lógica de navegación aquí
          if (index == 0) {
            Navigator.pushNamed(context, '/ventas'); // Navegar a la pantalla de inicio
          } else if (index == 1) {
            Navigator.pushNamed(context, '/inicio'); // Navegar a la pantalla del carrito
          } else if (index == 2) {
            Navigator.pushNamed(context, '/carrito'); // Ya estamos en la pantalla de ventas
          }
        },
        items: const [
            BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Ventas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),

        ],
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}
