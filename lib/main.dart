import 'package:flutter/material.dart';

import 'package:peliculas/src/pages/detalles_page.dart';
import 'package:peliculas/src/pages/home_page.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas APP',
      initialRoute: '/',
      routes: {
            '/'    :(context) => const HomePage(),
        'detalles' :(context) => const DetallesPage(),
      }
    );
  }
}