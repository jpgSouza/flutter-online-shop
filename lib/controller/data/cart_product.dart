import 'package:cloud_firestore/cloud_firestore.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/controller/data/product_data.dart';

class CartProduct{

  String cid;

  String categoty;
  String pid;

  int amount;
  String size;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot documentSnapshot){
    cid = documentSnapshot.documentID;
    categoty = documentSnapshot.data["category"];
    pid = documentSnapshot.data["pid"];
    amount = documentSnapshot.data["amount"];
    size = documentSnapshot.data["size"];
  }

  Map<String, dynamic>toMap(){
    return{
      "category": categoty,
      "pid": pid,
      "amount": amount,
      "size": size,
      "product": productData.toResumeMap()
    };
  }



}