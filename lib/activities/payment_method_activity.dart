import 'package:flutter/material.dart';
import 'package:flutter_online_shop/activities/credit_card_activity.dart';
import 'package:flutter_online_shop/model/credit_card_model.dart';
import 'package:scoped_model/scoped_model.dart';

class PaymentMethodActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(240, 80, 83, 0.7),
        elevation: 2.0,
        title: Text("Opções de Pagamento"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<CreditCard>(
        builder: (context, child, model) {
          return Form(
              child: ListView(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      width: 250.0,
                      height: 250.0,
                      left: 80.0,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('lib/images/credit_card.png'),
                        )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Adicionar forma de pagamento",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Tab(
                          icon: Container(
                              child: Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage('lib/images/visa_icon.png'),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text("VISA"),
                            ],
                          )),
                        ),
                        IconButton(
                            onPressed: () {
                              model.cardFlag = "VISA";
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreditCardActivity()));
                            },
                            icon: Icon(Icons.add_box,
                                color: Color.fromRGBO(240, 80, 83, 0.7))),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Tab(
                          icon: Container(
                              child: Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage(
                                    'lib/images/master_card_icon.png'),
                              ),
                              SizedBox(
                                width: 14.0,
                              ),
                              Text("MasterCard"),
                            ],
                          )),
                        ),
                        IconButton(
                          onPressed: () {
                            model.cardFlag = "MasterCard";
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CreditCardActivity()));
                          },
                          icon: Icon(
                            Icons.add_box,
                            color: Color.fromRGBO(240, 80, 83, 0.7),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              )
            ],
          ));
        },
      ),
    );
  }
}
