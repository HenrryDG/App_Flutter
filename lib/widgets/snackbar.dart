import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showCustomSnackBar(
    BuildContext context,
    String message, {
    VoidCallback? onActionPressed,
    String actionLabel = 'Ver carrito',
    Color backgroundColor = const Color.fromARGB(255, 55, 70, 153),
    Color textColor = Colors.white,
    Color actionTextColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
    IconData? icon,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(icon, color: textColor),
              ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(10),
        duration: duration,
        action: onActionPressed != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: actionTextColor,
                onPressed: onActionPressed,
              )
            : null,
      ),
    );
  }
}
