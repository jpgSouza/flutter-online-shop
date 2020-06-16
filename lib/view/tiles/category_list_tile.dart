import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/activities/admin_product_activity.dart';

class CategoryListTile extends StatelessWidget {
  final DocumentSnapshot _documentSnapshot;

  CategoryListTile(this._documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Card(
        elevation: 5.0,
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(_documentSnapshot.data["icon"]),
            backgroundColor: Colors.transparent,
          ),
          title: Text(
            "${_documentSnapshot.data["title"]}",
            style: TextStyle(color: Colors.grey[850]),
          ),
          children: <Widget>[
            FutureBuilder<QuerySnapshot>(
              future: _documentSnapshot.reference
                  .collection("items")
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(doc.data["images"][0]),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(doc.data["title"]),
                        trailing:
                            Text("R\$ ${doc.data["price"].toStringAsFixed(2)}"),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdminProductsActivity(
                                    categoryID: _documentSnapshot.documentID,
                                    documentSnapshot: doc,
                                  )));
                        },
                      );
                    }).toList()
                      ..add(ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.add_circle,
                            color: Color.fromARGB(255, 240, 80, 83),
                          ),
                        ),
                        title: Text(
                          "Adicionar",
                          style: TextStyle(color: Colors.grey[850]),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdminProductsActivity(
                                  categoryID: _documentSnapshot.documentID)));
                        },
                      )),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
