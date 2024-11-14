import 'package:carrito_compras/widgets/product._card.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> products = [
    // #REGION Productos
    Product(id: '1', nombre: 'CL Leather Hexalite', precio: '1199', imagenURL: 'https://fairplaybo.vtexassets.com/arquivos/ids/347420-1200-auto?v=638398250868300000&width=1200&height=auto&aspect=true', marca: 'Reebok'),
    Product(id: '2', nombre: 'Galaxy 6', precio: '594.3', imagenURL: 'https://fairplaybo.vtexassets.com/arquivos/ids/304761-300-auto?v=638334118800830000&width=300&height=auto&aspect=true', marca: 'Adidas'),
    Product(id: '3', nombre: 'SliptStream', precio: '594.3', imagenURL: 'https://fairplaybo.vtexassets.com/arquivos/ids/308879-300-auto?v=638334129006000000&width=300&height=auto&aspect=true',marca: 'Puma'),
    Product(id: '4', nombre: 'Run 70S', precio: '594.3', imagenURL: 'https://fairplaybo.vtexassets.com/arquivos/ids/305304-300-auto?v=638334120006730000&width=300&height=auto&aspect=true', marca: 'Adidas'),
    Product(id: '5', nombre: 'Nike Revolution 7', precio: '859', imagenURL: 'https://fairplaybo.vtexassets.com/arquivos/ids/406583-300-auto?v=638537248883730000&width=300&height=auto&aspect=true', marca: 'Nike'),
    Product(id: '6', nombre: 'Courtblock', precio: '594.3', imagenURL: 'https://fairplaybo.vtexassets.com/arquivos/ids/360085-300-auto?v=638461130930900000&width=300&height=auto&aspect=true', marca: 'Adidas'),
  ];

  

  String selectedBrand = 'Todos';
  List<String> brands = ['Todos', 'Reebok', 'Adidas', 'Puma', 'Nike'];

  // Variable para controlar la pantalla activa
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Filtrar los productos por marca seleccionada
    List<Product> filteredProducts = selectedBrand == 'Todos'
        ? products
        : products.where((product) => product.marca == selectedBrand).toList();

    return Scaffold(
      body: Column(
        children: [
          // Filtro en la parte superior con más margen y Dropdown más pequeño
          Padding(
            padding: const EdgeInsets.only(
              top: 60.0,
              left: 16.0,
              right: 16.0, // Añadido un margen superior mayor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 110.0, // Ajusta el ancho del dropdown
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  margin: const EdgeInsets.only(
                      top: 20.0), // Margen adicional si se necesita más espacio
                  decoration: BoxDecoration(
                    color: Colors.indigo, // Fondo de color indigo para el botón
                    borderRadius: BorderRadius.circular(
                        8.0), // Bordes redondeados para el contenedor
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedBrand,
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                      dropdownColor:
                        Colors.indigo, // Fondo del menú desplegable
                      style: const TextStyle(
                        color: Colors.white), // Color de texto
                      onChanged: (String? newValue) {
                      setState(() {
                        selectedBrand = newValue!;
                      });
                      },
                      borderRadius: BorderRadius.circular(8.0), // Añade border radius
                      items:
                          brands.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                color: Colors.white), // Estilo de texto
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Grid de productos
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true, // Ajusta el GridView al contenido
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio:
                      0.59, // Ajusta la relación de aspecto de las tarjetas
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductCard(
                      product: product); // Usa el widget personalizado
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
            Navigator.pushNamed(context, '/cart');
          } else {
            Navigator.pushNamed(context, '/home');
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
        showUnselectedLabels:
            true, // Mostrar etiquetas de los íconos no seleccionados
      ),
    );
  }
}
