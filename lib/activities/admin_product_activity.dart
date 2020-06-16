import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/bloc/product_bloc.dart';
import 'package:flutter_online_shop/widgets/images_widget.dart';

class AdminProductsActivity extends StatefulWidget {
  final String categoryID;
  final DocumentSnapshot documentSnapshot;

  AdminProductsActivity({this.categoryID, this.documentSnapshot});

  @override
  _AdminProductsActivityState createState() => _AdminProductsActivityState(categoryID, documentSnapshot);
}

class _AdminProductsActivityState extends State<AdminProductsActivity> {
  final _formKey = GlobalKey<FormState>();
  final ProductBloc _productBloc;

  _AdminProductsActivityState(String categoryID, DocumentSnapshot documentSnapshot)
      : _productBloc = ProductBloc(
            categoryID: categoryID, documentSnapshot: documentSnapshot);

  @override
  Widget build(BuildContext context) {
    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
          labelText: label, labelStyle: TextStyle(color: Colors.white));
    }

    final _fieldStyle = TextStyle(color: Colors.white, fontSize: 16.0);

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 80, 83),
        title: Text("Criar Produto"),
        elevation: 4.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<Map>(
          stream: _productBloc.outData,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Container();
            }else {
              return ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  Text("Imagens", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                  ImagesWidget(
                    context: context,
                    initialValue: snapshot.data["images"],
                    onSaved: (images){},
                    validator: (values){},
                  ),
                  TextFormField(
                    initialValue: snapshot.data["title"],
                    style: _fieldStyle,
                    decoration: _buildDecoration("Titulo"),
                    onSaved: (value) {},
                    validator: (value) {},
                  ),
                  TextFormField(
                    initialValue: snapshot.data["description"],
                    style: _fieldStyle,
                    maxLines: 3,
                    decoration: _buildDecoration("Descrição"),
                    onSaved: (value) {},
                    validator: (value) {},
                  ),
                  TextFormField(
                    initialValue: snapshot.data["price"]?.toStringAsFixed(2),
                    style: _fieldStyle,
                    decoration: _buildDecoration("Preço"),
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    onSaved: (value) {},
                    validator: (value) {},
                  )
                ],
              );
            }
          }
        ),
      ),
    );
  }
}
