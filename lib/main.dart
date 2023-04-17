import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tabs_page.dart';
import 'package:newsapp/src/theme/tema.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: miTema,
      home: TabsPage(),
    );
  }
}
