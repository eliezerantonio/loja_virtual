import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  OrderTile(this.orderId);

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.green,
                ),
              );
            else {
              int status = snapshot.data["status"];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Codigo do pedido: ${snapshot.data.documentID}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(_buildProductText(snapshot.data)),
                  Text(
                    "Status do Pedido: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircle("1", "Preparação", status, 1),
                      Container(height: 1, width: 40, color: Colors.grey[500]),
                      _buildCircle("2", "Transporte", status, 2),
                      Container(height: 1, width: 40, color: Colors.grey[500]),
                      _buildCircle("3", "Entrega", status, 3),
                    ],
                  )
                ],
              );
            }
          },
          stream: Firestore.instance
              .collection("orders")
              .document(orderId)
              .snapshots(),
        ),
      ),
    );
  }
}

String _buildProductText(DocumentSnapshot snapshot) {
  String text = "Descrição:\n";
  for (LinkedHashMap p in snapshot.data["products"]) {
    text += "${p["quantity"]} x ${p["product"]["title"]} (KZ "
        "${p["product"]["price"].toStringAsFixed(2)})\n";
  }
  text += "Total: KZ ${snapshot.data["totalPrice"].toStringAsFixed(2)}";

  return text;
}

Widget _buildCircle(String title, String subtitle, int status, int thisStatus) {
  Color backColor;
  Widget child;
  if (status < thisStatus) {
    //ainda nao cheagamos
    backColor = Colors.grey[500];
    child = Text(
      title,
      style: TextStyle(color: Colors.white),
    );
  } else if (status == thisStatus) {
    // cheagamos
    backColor = Colors.blue;
    child = Stack(
      alignment: Alignment.center,
      children: [
        child = Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
      ],
    );
  } else {
    backColor = Colors.green;
    child = Icon(Icons.check, color: Colors.white,);
  }
  return Column(
    children: [
      CircleAvatar(
        radius: 20,
        backgroundColor: backColor,
        child: child,
      )
    ],
  );
}
