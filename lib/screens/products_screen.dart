import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class ProductsScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ProductsScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data["title"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance
                .collection("products")
                .document(snapshot.documentID)
                .collection("items")
                .getDocuments(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    //GRID
                    GridView.builder(
                      padding: EdgeInsets.all(4),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductTile(
                            "grid",
                            ProductData.fromDocument(
                                snapshot.data.documents[index]));
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          childAspectRatio: 0.65),
                      itemCount: snapshot.data.documents.length,
                    ),
                    //LIST
                    ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                          "list",
                          ProductData.fromDocument(
                              snapshot.data.documents[index]),
                        );
                      },
                    )
                  ],
                );
              }
            },
          )),
    );
  }
}
