import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/activities/payment_method_activity.dart';
import 'package:flutter_online_shop/data/card_data.dart';
import 'package:flutter_online_shop/model/credit_card_model.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

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
                future: Firestore.instance.collection("users")
                    .document(User.of(context).firebaseUser.uid).collection("creditCard").getDocuments(),
                builder: (context, docSnapshot){
                  if(docSnapshot.data.documents.isEmpty){
                    return Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Nenhuma forma de pagamento",
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      PaymentMethodActivity()));
                            },
                          )
                        ],
                      ),
                    );
                  }else{
                    CardData cardData = CardData.fromDocument(docSnapshot.data.documents[0]);
                    return FutureBuilder<DocumentSnapshot>(
                      future: Firestore.instance.collection("users")
                          .document(User.of(context).firebaseUser.uid).collection("creditCard").document(cardData.cardId).get(),
                      builder: (context, snapshot){
                        if(snapshot.data == null){
                          return CircularProgressIndicator();
                        }else{
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
                                                snapshot.data["flag"] == "VISA"
                                                    ? 'lib/images/visa_icon.png'
                                                    : 'lib/images/master_card_icon.png'),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(snapshot.data["cardName"]),
                                        ],
                                      )),
                                ),
                                ButtonBar(
                                  children: <Widget>[
                                    Radio(
                                      value: 1,
                                      groupValue: 1,
                                      activeColor: Color.fromRGBO(240, 80, 83, 0.7),
                                      onChanged: (val) {},
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                      },
                    );
                  } 
                },
              )),
        ],
      ),
    );
  }
}
