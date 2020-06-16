import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/tabs/orders_tab.dart';

class SuccessfulOrderActivity extends StatelessWidget {
  final String orderID;

  SuccessfulOrderActivity(this.orderID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 80, 83, 0.7),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle_outline,
              color: Color.fromARGB(255, 240, 80, 83),
              size: 80.0,
            ),
            Text(
              "Pedido realizado com Sucesso!",
              style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            Text(
              "Código do produto",
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              "${orderID}",
              style: TextStyle(color: Colors.grey[500], fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
