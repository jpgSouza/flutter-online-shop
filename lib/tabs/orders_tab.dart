import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/activities/login_activity.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:flutter_online_shop/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (User.of(context).isLoggedIn()) {

      String uid = User.of(context).firebaseUser.uid;
      
      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("users").document(uid).collection("orders").getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return ListView(
              children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList(),
            );
          }
        },
      );

    } else {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.not_interested,
              size: 60.0,
              color: Color.fromARGB(255, 240, 80, 83),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Faça o login para ver seus pedidos!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500]),
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginActivity()));
              },
              color: Color.fromARGB(255, 0, 90, 163),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 255, 253, 228),
                      Color.fromARGB(255, 240, 80, 83),
                    ], begin: Alignment.bottomLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 400.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Entrar",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      );
    }
  }
}
