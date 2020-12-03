import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartProduct {
  CartProduct.fromDocument(DocumentSnapshot documentSnapshot) {
    cid = documentSnapshot.documentID;
    category = documentSnapshot.data["category"];
    pid=documentSnapshot.data["pid"];
    quantity=documentSnapshot.data["quantity"];
    size=documentSnapshot.data["size"];


  }
  CartProduct();

  Map<String, dynamic> toMap(){
    return {
      "category":category,
      "pid":pid,
      "quantity":quantity,
      "size":size,
      "product":productData.toResumedMap()
    };
  }

  String cid;
  String category;
  String pid;
  int quantity;
  String size;

  ProductData productData;
}
