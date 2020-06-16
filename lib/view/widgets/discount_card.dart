import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_online_shop/model/cart_model.dart';

class DiscountCoupon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ExpansionTile(
        title: Text(
          "Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[500],
          ),
        ),
        trailing: Icon(
          Icons.add,
          color: Color.fromRGBO(240, 80, 83, 0.7),
          size: 28.0,
        ),
        leading: Icon(
          Icons.local_offer,
          color: Color.fromRGBO(240, 80, 83, 0.7),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 240, 80, 83),
                  )),
                  border: OutlineInputBorder(),
                  hintText: "Digite seu cupom",
                  hintStyle: TextStyle(color: Colors.grey[400])),
              initialValue: Cart.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection("coupons")
                    .document(text)
                    .get()
                    .then((docSnapshot) {
                  if (docSnapshot.data != null) {
                    Cart.of(context).applyDiscount(text, docSnapshot.data["percent"]);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Desconto de ${docSnapshot.data["percent"]}% aplicado!",
                          textAlign: TextAlign.center,),
                      backgroundColor: Color.fromARGB(255, 0, 90, 163),
                      duration: Duration(seconds: 2),
                    ));
                  } else {
                    Cart.of(context).applyDiscount(null, 0);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Cupom de disconto inválido!",
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 2),
                    ));
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
