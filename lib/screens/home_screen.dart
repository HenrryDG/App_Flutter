import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../services/firestore_service.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Producto> productos = [];
  bool isLoading = true;
  String filtroSeleccionado = 'Todos';
  List<String> brands = ['Todos', 'Reebok', 'Adidas', 'Puma', 'Nike'];

  // Controlar la pantalla activa
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProductos();
  }

  Future<void> _loadProductos() async {
    FirestoreService firestoreService = FirestoreService();
    List<Producto> fetchedProductos = await firestoreService.getProductos();
    setState(() {
      productos = fetchedProductos;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar los productos
    List<Producto> productosFiltrados = filtroSeleccionado == 'Todos'
        ? productos
        : productos
            .where((product) => product.marca == filtroSeleccionado)
            .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título y filtro
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tienda de Ropa",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: brands.map((brand) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(brand),
                            selected: filtroSeleccionado == brand,
                            onSelected: (bool selected) {
                              setState(() {
                                filtroSeleccionado = selected ? brand : 'Todos';
                              });
                            },
                            selectedColor: Colors.indigo,
                            backgroundColor: Colors.grey[300],
                            labelStyle: TextStyle(
                              color: filtroSeleccionado == brand
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Mostrar productos
            isLoading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: productosFiltrados.length,
                        itemBuilder: (context, index) {
                          final product = productosFiltrados[index];
                          return ProductCard(producto: product);
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 10,
        currentIndex: 1,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });

          if (_currentIndex == 0) {
            Navigator.pushNamed(context, '/ventas'); // Navegar a la pantalla de compras
          } else if (_currentIndex == 1) {
            Navigator.pushNamed(context, '/inicio'); // Navegar al inicio
          } else if (_currentIndex == 2) {
            Navigator.pushNamed(context, '/carrito'); // Navegar al carrito
          }
        },
        items: const [
            BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.sell),
            label: 'Compras',
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
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      ),
    );
  }
}
