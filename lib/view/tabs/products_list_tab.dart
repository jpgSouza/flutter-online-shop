import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/tiles/category_list_tile.dart';

class ProductsListTab extends StatefulWidget {
  @override
  _ProductsListTabState createState() => _ProductsListTabState();
}

class _ProductsListTabState extends State<ProductsListTab> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("products").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return CategoryListTile(snapshot.data.documents[index]);
              });
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
