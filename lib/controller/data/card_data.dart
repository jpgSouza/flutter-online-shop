import 'package:cloud_firestore/cloud_firestore.dart';

class CardData{

  String cardId;
  String cardName;
  String cardNumber;
  String cardExpirationDate;
  String cardSecurityCode;
  String cardFlag;


  CardData.fromDocument(DocumentSnapshot documentSnapshot){
    cardId = documentSnapshot.documentID;
    cardName = documentSnapshot.data["cardName"];
    cardNumber = documentSnapshot.data["cardNumber"];
    cardExpirationDate = documentSnapshot.data["cardExpirationDate"];
    cardSecurityCode = documentSnapshot.data["cardSecurityCode"];
    cardFlag = documentSnapshot.data["flag"];
  }


}