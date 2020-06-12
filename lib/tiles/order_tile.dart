import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String orderID;

  OrderTile(this.orderID);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection("orders")
                .document(orderID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Código do pedido: ${snapshot.data.documentID}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                        _buildProducts(snapshot.data)
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Status do Pedido",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildStatusCircle("1", "Preparação", snapshot.data["status"], 1),
                        Container(
                          height: 1.0,
                          width: 40.0,
                          color: Colors.grey[500],
                        ),
                        _buildStatusCircle("2", "Transporte", snapshot.data["status"], 2),
                        Container(
                          height: 1.0,
                          width: 40.0,
                          color: Colors.grey[500],
                        ),
                        _buildStatusCircle("3", "Entregue", snapshot.data["status"], 3),
                      ],
                    )
                  ],
                );
              }
            }),
      ),
    );
  }

  String _buildProducts(DocumentSnapshot documentSnapshot) {
    String text = "Descrição:\n";
    for (LinkedHashMap linkedHashMap in documentSnapshot.data["products"]) {
      text +=
      "${linkedHashMap["amount"]} x ${linkedHashMap["product"]["title"]} (R\$ ${linkedHashMap["product"]["price"]
          .toStringAsFixed(2)})\n";
    }
    text += "Total: R\$ ${documentSnapshot.data["total"].toStringAsFixed(2)}";

    return text;
  }

  Widget _buildStatusCircle(String title, String subTitle, int status, int thisStatus){

    Color _backgroundColor;
    Widget _child;

    if(status < thisStatus){
      _backgroundColor = Colors.grey[500];
      _child = Text(title, style: TextStyle(color: Colors.white),);
    }else if(status == thisStatus){
      _backgroundColor = Color.fromARGB(255, 240, 80, 83);
      _child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.white),),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    }else{
      _backgroundColor = Colors.green;
      _child = Icon(Icons.check, color: Colors.white,);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: _backgroundColor,
          child: _child,
        ),
        Text(subTitle)
      ],
    );

  }

}
