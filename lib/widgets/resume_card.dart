import 'package:flutter/material.dart';
import 'package:flutter_online_shop/model/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ResumeCard extends StatelessWidget {

  final VoidCallback buy;

  ResumeCard(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Container(
          padding: EdgeInsets.all(20.0),
          child: ScopedModelDescendant<Cart>(
            builder: (context, child, model) {

              double subTotal = model.cartSubTotal();
              double discount = model.cartDiscount();
              double shipping = model.cartShipping();


              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Resumo do pedido",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Subtotal"),
                      Text("R\$ ${subTotal.toStringAsFixed(2)}"),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Desconto"),
                      Text(discount == 0.00 ? "R\$ ${discount.toStringAsFixed(2)}" : "R\$ -${discount.toStringAsFixed(2)}"),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Frete"),
                      Text("R\$ ${shipping.toStringAsFixed(2)}"),
                    ],
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 240, 80, 83)),
                      ),
                      Text(
                        "R\$ ${(subTotal + shipping - discount).toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 240, 80, 83)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  RaisedButton(
                    onPressed: buy,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
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
                            borderRadius: BorderRadius.circular(14.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 400.0, minHeight: 40.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Finalizar pedido",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        )),
                  ),
                ],
              );
            },
          )),
    );
  }
}
