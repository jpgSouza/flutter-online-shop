import 'package:flutter/material.dart';
import 'package:flutter_online_shop/activities/credit_card_activity.dart';

class PaymentMethodCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ExpansionTile(
        title: Text(
          "Forma de Pagamento",
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
          Icons.credit_card,
          color: Color.fromRGBO(240, 80, 83, 0.7),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(icon: Icon(Icons.add), onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CreditCardActivity()));
            },),
          ),
        ],
      ),
    );
  }
}
