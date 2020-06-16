import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/controller/bloc/user_bloc.dart';

class OrderHeader extends StatelessWidget {

  final DocumentSnapshot _documentSnapshot;

  OrderHeader(this._documentSnapshot);

  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.of<UserBloc>(context);
    final _user = _userBloc.getUserInfo(_documentSnapshot.data["userID"]);
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("${_user["name"]}"),
              Text("${_user["cep"]}")
            ],
          )
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("SubTotal: R\$${_documentSnapshot.data["subTotal"].toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold),),
            Text("Total: R\$${_documentSnapshot.data["total"].toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        )
      ],
    );
  }
}
