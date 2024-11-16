class Producto {
  final String id;
  final String nombre;
  final String precio;
  final String imagenURL;
  final String marca;
  final String genero; // Campo para género
  final String categoria; // Campo para categoría
  final List<dynamic> tallas; // Campo flexible para tallas (números o cadenas)
  int cantidad;
  String tallaSeleccionada; // Campo para talla seleccionada

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.imagenURL,
    required this.marca,
    required this.genero,
    required this.categoria,
    required this.tallas, // Campo flexible para tallas
    this.cantidad = 1,
    this.tallaSeleccionada = "",
  });
}
