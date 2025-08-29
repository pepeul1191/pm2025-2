import 'package:biblioapp/configs/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el TextTheme por defecto sin depender de un BuildContext
    final TextTheme baseTextTheme = Typography.material2021().englishLike;
    final MaterialTheme materialTheme = MaterialTheme(baseTextTheme);

    return MaterialApp(
      title: 'Hola Mundo',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Mi Primera App')),
      body: Center(
        child: Text(
          '¡Hola Mundo!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
