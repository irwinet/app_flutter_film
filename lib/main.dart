import 'package:app_flutter_film/src/pages/film_detail.dart';
import 'package:app_flutter_film/src/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Films',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'detail' : (BuildContext context) => FilmDetail(),
      },
    );
  }
}