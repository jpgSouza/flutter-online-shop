import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/activities/cart_activity.dart';
import 'package:flutter_online_shop/model/credit_card_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CreditCardActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 80, 83, 0.7),
        elevation: 2.0,
        centerTitle: true,
      ),
      body: ScopedModelDescendant<CreditCard>(
        builder: (context, child, model) {
          return Form(
              child: ListView(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30.0),
                color: Colors.transparent,
                width: 300.0,
                height: 320.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      width: 350.0,
                      height: 250.0,
                      left: 20.0,
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  blurRadius: 14.0,
                                  offset: Offset(4, 14))
                            ],
                            image: DecorationImage(
                                image: AssetImage(
                                    'lib/images/credit_card_register.png'),
                                fit: BoxFit.fill)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: model.cardName,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 80, 83),
                          )),
                          border: OutlineInputBorder(),
                          hintText: "Titular do Cartão",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.person,
                              color: Color.fromRGBO(240, 80, 83, 0.7))),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: model.cardNumber,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 80, 83),
                          )),
                          border: OutlineInputBorder(),
                          hintText: "Número do Cartão",
                          hintStyle: TextStyle(color: Colors.grey[400]), prefixIcon: Icon(Icons.credit_card,
                          color: Color.fromRGBO(240, 80, 83, 0.7))),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            width: 300.0,
                            child: TextFormField(
                              controller: model.cardExpirationDate,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color.fromARGB(255, 240, 80, 83),
                                  )),
                                  border: OutlineInputBorder(),
                                  hintText: "Validade",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400]), prefixIcon: Icon(Icons.date_range,
                                  color: Color.fromRGBO(240, 80, 83, 0.7))),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            width: 120,
                            child: TextFormField(
                              controller: model.cardSecurityCode,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color.fromARGB(255, 240, 80, 83),
                                  )),
                                  border: OutlineInputBorder(),
                                  hintText: "CVV",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400]), prefixIcon: Icon(Icons.lock,
                                  color: Color.fromRGBO(240, 80, 83, 0.7))),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Map<String, dynamic> cardData = {
                          "cardName": model.cardName.text,
                          "cardNumber": model.cardNumber.text,
                          "cardExpirationDate": model.cardExpirationDate.text,
                          "cardSecurityCode": model.cardSecurityCode.text,
                          "flag": model.cardFlag,
                        };

                        model.createCard(cardData);

                        Navigator.of(context).pop();

                      },
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
                              "Adicionar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ));
        },
      ),
    );
  }
}
