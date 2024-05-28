import 'package:flutter/material.dart';
import 'package:product_crud_app/view/product_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      themeMode: ThemeMode.system,
      theme: _lightThemeData(),
      darkTheme: _darkThemeData(),
      home: const ProductListView(),
    );
  }
}

ThemeData _lightThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    ),
    appBarTheme:
        const AppBarTheme(color: Colors.blue, foregroundColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      fixedSize: const Size.fromWidth(double.maxFinite),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    ),
    floatingActionButtonTheme:const FloatingActionButtonThemeData(backgroundColor: Colors.blue,foregroundColor: Colors.white)
    ,
  );
}

ThemeData _darkThemeData() {
  return ThemeData(
    brightness: Brightness.dark,
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    ),
    appBarTheme:
        const AppBarTheme(color: Colors.blue, foregroundColor: Colors.white),
  );
}
