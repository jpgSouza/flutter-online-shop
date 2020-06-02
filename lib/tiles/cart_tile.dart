import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/data/cart_product.dart';
import 'package:flutter_online_shop/data/product_data.dart';
import 'package:flutter_online_shop/model/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      Cart.of(context).updatePrices();
      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(
              cartProduct.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cartProduct.productData.title,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 17.0),
                      ),
                      Text(
                        "Tamanho: ${cartProduct.size}",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "R\$ ${cartProduct.productData.price.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Color.fromARGB(255, 240, 80, 83),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Cart.of(context).removeCart(cartProduct);
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            Text(
                              "Remover",
                              style: TextStyle(color: Colors.grey[500]),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 32.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.add_circle_outline,
                        ),
                        color: Color.fromARGB(255, 240, 80, 83),
                        onPressed: () {
                          Cart.of(context).incAmount(cartProduct);
                        },
                      ),
                      Text(cartProduct.amount.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                      IconButton(
                        icon: Icon(
                          Icons.remove_circle_outline,
                        ),
                        color: Color.fromARGB(255, 240, 80, 83),
                        onPressed: cartProduct.amount > 1 ? () {
                          Cart.of(context).decAmount(cartProduct);
                        } : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        elevation: 5.0,
        child: cartProduct.productData == null
            ? FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection("products")
                    .document(cartProduct.categoty)
                    .collection("items")
                    .document(cartProduct.pid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    cartProduct.productData =
                        ProductData.fromDocument(snapshot.data);
                    return _buildContent();
                  } else {
                    return Container(
                      height: 70.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            : _buildContent());
  }
}
