import 'package:carrito_compras/widgets/product_card.dart';
import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../services/firestore_service.dart';

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

  // Variable para controlar la pantalla activa
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
    // Filtrar los productos por marca seleccionada
    List<Producto> productosFiltrados = filtroSeleccionado == 'Todos'
        ? productos
        : productos.where((product) => product.marca == filtroSeleccionado).toList();

    return Scaffold(
      body: Column(
        children: [
          // Filtro en la parte superior
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 110.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  margin: const EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: filtroSeleccionado,
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                      dropdownColor: Colors.indigo,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (String? newValue) {
                        setState(() {
                          filtroSeleccionado = newValue!;
                        });
                      },
                      items: brands.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Mostrar los productos
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.59,
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });

          if (_currentIndex == 1) {
            Navigator.pushNamed(context, '/carrito');
          } else {
            Navigator.pushNamed(context, '/inicio');
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
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
