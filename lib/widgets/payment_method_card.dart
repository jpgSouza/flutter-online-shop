import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
              child: FutureBuilder<QuerySnapshot>(
                future: Firestore.instance
                    .collection("users")
                    .document(CreditCard
                    .of(context)
                    .user
                    .firebaseUser
                    .uid).collection("creditCard").getDocuments(),
                builder: (context, snapshot) {
                  if (snapshot.data.documents.isNotEmpty) {
                    return Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Tab(
                            icon: Container(
                                child: Row(
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage(
                                          snapshot.data.documents[0]
                                              .data["flag"] == "VISA"
                                              ? 'lib/images/visa_icon.png'
                                              : 'lib/images/master_card_icon.png'),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(snapshot.data.documents[0].data["cardName"]),
                                  ],
                                )),
                          ),
                          ButtonBar(
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: 1,
                                activeColor: Color.fromRGBO(240, 80, 83, 0.7),
                                onChanged: (val){
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Nenhuma forma de pagamento", style: TextStyle(
                              color: Colors.grey[500]),),
                          IconButton(icon: Icon(Icons.add), onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaymentMethodActivity()));
                          },)
                        ],
                      ),
                    );
                  }
                },
              )),
        ],
      ),
    );
  }
}
