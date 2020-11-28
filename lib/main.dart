import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/home_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Loja virtual",
      theme: ThemeData(
        primarySwatch: Colors.green,
      
       accentColor: Colors.black54,
        primaryColor: Colors.green
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
