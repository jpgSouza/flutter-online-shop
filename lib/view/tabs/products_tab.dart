import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/tiles/products_tile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("products").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          var dividedTiles = ListTile.divideTiles(
            tiles: snapshot.data.documents.map((doc) {
              return ProductsTile(doc);
            }).toList(),
            color: Colors.grey,
          ).toList();

          return ListView(
            children: dividedTiles,
          );
        }
      },
    );
  }
}
