import 'package:flutter/material.dart';

class Etiqueta extends StatelessWidget {
  final String texto;

  const Etiqueta({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.1), // Fondo con opacidad
        borderRadius: BorderRadius.circular(5), // Bordes redondeados
        border: Border.all(color: Colors.indigo, width: 1), // Borde
      ),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.indigo,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
