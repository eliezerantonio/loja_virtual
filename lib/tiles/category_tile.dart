import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/products_screen.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 35,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(snapshot.data["icon"]),
        ),
        title: Text(snapshot.data["title"]),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){
Navigator.of(context).push(MaterialPageRoute(builder: (context)
=>ProductsScreen(snapshot)));
        },
      ),
    );
  }
}
