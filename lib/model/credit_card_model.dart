import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_online_shop/data/card_data.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CreditCard extends Model {

  List<CardData> cards = [];
  Map<String, dynamic> creditCardData = Map();

  User user;

  final cardName = TextEditingController();
  final cardNumber = TextEditingController();
  final cardExpirationDate = TextEditingController();
  final cardSecurityCode = TextEditingController();

  String cardFlag;
  String cardId;

  CreditCard(this.user){
    if(this.user.isLoggedIn()) loadCard();
  }

  static CreditCard of(BuildContext context) =>
      ScopedModel.of<CreditCard>(context);

  void createCard(Map<String, dynamic> cardData) async {
    await _saveCreditCard(cardData);

    notifyListeners();
  }

  Future<Null> _saveCreditCard(Map<String, dynamic> creditCardData) async {
    this.creditCardData = creditCardData;

    await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("creditCard")
        .add(creditCardData).then((doc){
          cardId = doc.documentID;
    });

    print(cardId);

  }

  void loadCard() async {

    QuerySnapshot querySnapshot = await Firestore.instance.collection("users")
    .document(user.firebaseUser.uid).collection("creditCard").getDocuments();

    cards = querySnapshot.documents.map((doc) => CardData.fromDocument(doc)).toList();

    print(cards);

    notifyListeners();

  }


}
