import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_online_shop/data/cart_product.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Cart extends Model {
  User user;

  List<CartProduct> products = [];
  bool isLoading = false;

  String couponCode;
  int discountPercentage = 0;

  Cart(this.user) {
    if (user.isLoggedIn()) _loadCart();
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

    products = querySnapshot.documents
        .map((doc) => CartProduct.fromDocument(doc))
        .toList();

    notifyListeners();
  }

  void applyDiscount(String couponCode, int percent) {
    this.couponCode = couponCode;
    this.discountPercentage = percent;
  }

  void updatePrices() {
    notifyListeners();
  }

  double cartSubTotal() {
    double price = 0.0;
    for (CartProduct cartProduct in products) {
      if (cartProduct.productData != null) {
        price += cartProduct.amount * cartProduct.productData.price;
      }
    }
    return price;
  }

  double cartShipping() {
    return 4.99;
  }

  double cartDiscount() {
    return cartSubTotal() * discountPercentage / 100.0;
  }

  Future<String> finishOrder() async {
    if (products.length == 0) return null;
    isLoading = true;
    notifyListeners();

    double productPrice = cartSubTotal();
    double productShipping = cartShipping();
    double discount = cartDiscount();

    DocumentReference documentReference =
        await Firestore.instance.collection("orders").add({
      "userID": user.firebaseUser.uid,
      "products": products.map((cartProduct) => cartProduct.toMap()).toList(),
      "shippPrice:": productShipping,
      "subTotal": productPrice,
      "discount": discount,
      "total": productPrice - discount + productShipping,
      "status": 1
    });

    await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("orders")
        .document(documentReference.documentID)
        .setData({"orderID": documentReference.documentID});

    QuerySnapshot querySnapshot = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    for(DocumentSnapshot documentSnapshot in querySnapshot.documents){
      documentSnapshot.reference.delete();
    }

    products.clear();
    couponCode = null;
    discountPercentage = 0;

    isLoading = false;
    notifyListeners();

    return documentReference.documentID;

  }
}
