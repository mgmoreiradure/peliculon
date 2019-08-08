import 'package:flutter/material.dart';
import 'package:peliculon/src/pages/home_page.dart';
import 'package:peliculon/src/pages/pelicula_detalle_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculón',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context)=>PeliculaDetalle(),

      },
    );
  }
}