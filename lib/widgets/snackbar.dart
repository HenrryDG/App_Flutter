import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showCustomSnackBar(BuildContext context, String message, {VoidCallback? onActionPressed}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 55, 70, 153),
        behavior: SnackBarBehavior.floating, // Hacer que el SnackBar flote
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados
        ),
        margin: const EdgeInsets.all(10), // Espaciado alrededor del SnackBar
        duration: const Duration(seconds: 2), // Duración del SnackBar
        action: onActionPressed != null
            ? SnackBarAction(
                label: 'Ver carrito',
                textColor: Colors.white,
                onPressed: onActionPressed,
              )
            : null,
      ),
    );
  }
}
