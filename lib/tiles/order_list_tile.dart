import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/widgets/order_header.dart';

class OrderListTile extends StatelessWidget {
  final DocumentSnapshot _documentSnapshot;
  final Firestore _firestore = Firestore.instance;

  OrderListTile(this._documentSnapshot);

  final states = [
    "",
    "Em preparação",
    "Em transporte",
    "Aguardando Entrega",
    "Entregue"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 5.0,
        child: ExpansionTile(
          key: Key(_documentSnapshot.documentID),
          title: Text(
            "${_documentSnapshot.documentID.substring(_documentSnapshot.documentID.length - 7, _documentSnapshot.documentID.length)}"
            " - ${states[_documentSnapshot.data["status"]]}",
            style: TextStyle(
                color: _documentSnapshot.data["status"] != 4
                    ? Colors.grey[850]
                    : Colors.green),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  OrderHeader(_documentSnapshot),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _documentSnapshot.data["products"]
                        .map<Widget>((product) {
                      return ListTile(
                        title: Text(
                            "${product["product"]["title"] + " - " + "${product["size"]}"}"),
                        subtitle: Text(
                            "${product["category"] + "/" + product["pid"]}"),
                        trailing: Text("Qtd: ${product["amount"].toString()}"),
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: _documentSnapshot.data["status"] == 4 ? (){
                          _firestore
                              .collection("users")
                              .document(_documentSnapshot["userID"])
                              .collection("orders")
                              .document(_documentSnapshot.documentID)
                              .delete();
                          _documentSnapshot.reference.delete();
                        } : null,
                        child: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                      FlatButton(
                        onPressed: _documentSnapshot.data["status"] > 1
                            ? () {
                                _documentSnapshot.reference.updateData({
                                  "status": _documentSnapshot.data["status"] - 1
                                });
                              }
                            : null,
                        textColor: Colors.grey[850],
                        child: Text("Regredir"),
                      ),
                      FlatButton(
                          onPressed: _documentSnapshot.data["status"] < 4
                              ? () {
                                  _documentSnapshot.reference.updateData({
                                    "status":
                                        _documentSnapshot.data["status"] + 1
                                  });
                                }
                              : null,
                          textColor: Colors.green,
                          child: Text("Avançar")),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
