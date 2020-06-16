import 'package:flutter/material.dart';

class ShippingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ExpansionTile(
        title: Text(
          "Calcular Frete",
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
          Icons.local_shipping,
          color: Color.fromRGBO(240, 80, 83, 0.7),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 240, 80, 83),
                  )),
                  border: OutlineInputBorder(),
                  hintText: "Digite seu CEP",
                  hintStyle: TextStyle(color: Colors.grey[400])),
            ),
          ),
        ],
      ),
    );
  }
}
