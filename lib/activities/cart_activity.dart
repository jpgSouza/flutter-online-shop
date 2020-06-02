import 'package:flutter/material.dart';
import 'package:flutter_online_shop/activities/login_activity.dart';
import 'package:flutter_online_shop/model/cart_model.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:flutter_online_shop/tiles/cart_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CartActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(240, 80, 83, 0.7),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 14.0, right: 14.0, bottom: 14.0, top: 12.0),
            child: ScopedModelDescendant<Cart>(
              builder: (context, child, model) {
                int amount = model.products.length;
                return Stack(
                  children: <Widget>[
                    Icon(Icons.shopping_cart, size: 34.0),
                    Positioned(
                        bottom: 14.0,
                        left: 17.0,
                        child: Container(
                          width: 16.0,
                          height: 16.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black,
                          ),
                          child: Text(
                            "${amount ?? 0}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ],
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<Cart>(
        builder: (context, child, model) {
          if (model.isLoading && User.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!User.of(context).isLoggedIn()) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.highlight_off,
                    size: 60.0,
                    color: Color.fromARGB(255, 240, 80, 83),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Faça o login para adicionar produtos!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500]),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginActivity()));
                    },
                    color: Color.fromARGB(255, 0, 90, 163),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 253, 228),
                                Color.fromARGB(255, 240, 80, 83),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 400.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Entrar",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            );
          } else if (model.products == null || model.products.length == 0) {
            return Center(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.remove_shopping_cart,
                      color: Color.fromARGB(255, 240, 80, 83),
                      size: 60,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      "Nenhum produto no carrinho!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[500], fontSize: 18.0),
                    )
                  ],
                ),
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products.map((product) {
                    return CartTile(product);
                  }).toList(),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
