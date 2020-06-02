import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_online_shop/data/cart_product.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Cart extends Model {
  User user;

  List<CartProduct> products = [];
  bool isLoading = false;

  Cart(this.user){
    if(user.isLoggedIn())
      _loadCart();
  }

  static Cart of(BuildContext context) => ScopedModel.of<Cart>(context);

  void addCart(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeCart(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .delete();

    products.remove(cartProduct);

    notifyListeners();
  }

  void incAmount(CartProduct cartProduct) {
    cartProduct.amount++;

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void decAmount(CartProduct cartProduct) {
    cartProduct.amount--;

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCart() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    products = querySnapshot.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();

  }

}
