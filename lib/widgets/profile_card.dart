import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.grey[300],
        elevation: 5.0,
        margin: EdgeInsets.all(14.0),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Infomações Gerais"),
                  IconButton(
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.keyboard_arrow_right),
                    color: Color.fromRGBO(240, 80, 83, 0.7),
                    iconSize: 28.0,
                    onPressed: () {},
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Endereço de Cobrança"),
                  IconButton(
                    padding: EdgeInsets.all(0.0),
                    iconSize: 28.0,
                    icon: Icon(Icons.keyboard_arrow_right),
                    color: Color.fromRGBO(240, 80, 83, 0.7),
                    onPressed: () {},
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Formas de Pagamento"),
                  IconButton(
                    padding: EdgeInsets.all(0.0),
                    iconSize: 28.0,
                    icon: Icon(Icons.keyboard_arrow_right),
                    color: Color.fromRGBO(240, 80, 83, 0.7),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
