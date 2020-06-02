import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
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
          color: Color.fromRGBO(240, 80, 83, 0.7),
          size: 28.0,
        ),
        leading: Icon(
          Icons.credit_card,
          color: Color.fromRGBO(240, 80, 83, 0.7),
        ),
      ),
    );
  }
}
