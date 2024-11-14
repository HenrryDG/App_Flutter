import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Carrito de Compras',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(),
        routes: {
          '/carrito': (context) => const CartScreen(),
          '/inicio': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
