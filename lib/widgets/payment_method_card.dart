import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/activities/credit_card_activity.dart';
import 'package:flutter_online_shop/activities/payment_method_activity.dart';
import 'package:flutter_online_shop/model/credit_card_model.dart';

class PaymentMethodCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ExpansionTile(
        title: Text(
          "Forma de Pagamento",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[500],
          ),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_down,
          size: 28.0,
          color: Color.fromRGBO(240, 80, 83, 0.7),
        ),
        leading: Icon(
          Icons.credit_card,
          color: Color.fromRGBO(240, 80, 83, 0.7),
        ),
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: Firestore.instance.collection("users")
                    .document(CreditCard.of(context).user.firebaseUser.uid).collection("creditCard")
                    .document(CreditCard.of(context).cardId).snapshots(),
                builder: (context, snapshot){
                  return Text("Contador: ${snapshot.data["cardName"]}");
                },
              )
          )
        ],
      ),
    );
  }
}
