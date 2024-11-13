class Product {
  final String id;
  final String nombre;
  final String precio;
  final String imagenURL;
  final String marca;
  int cantidad;

  Product({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.imagenURL,
    required this.marca,
    this.cantidad = 1,
  });
}