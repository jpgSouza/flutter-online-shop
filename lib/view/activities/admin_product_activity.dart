import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/controller/bloc/product_bloc.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/controller/validators/products_validator.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/widgets/add_product_size.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/widgets/images_widget.dart';

class AdminProductsActivity extends StatefulWidget {
  final String categoryID;
  final DocumentSnapshot documentSnapshot;

  AdminProductsActivity({this.categoryID, this.documentSnapshot});

  @override
  _AdminProductsActivityState createState() =>
      _AdminProductsActivityState(categoryID, documentSnapshot);
}

class _AdminProductsActivityState extends State<AdminProductsActivity>
    with ProductsValidator {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final ProductBloc _productBloc;

  _AdminProductsActivityState(
      String categoryID, DocumentSnapshot documentSnapshot)
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
        key: _scaffoldKey,
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 240, 80, 83),
          title: StreamBuilder<bool>(
              stream: _productBloc.outCreated,
              initialData: false,
              builder: (context, snapshot) {
                return Text(snapshot.data ? "Editar produto" : "Criar Produto");
              }),
          elevation: 4.0,
          actions: <Widget>[
            StreamBuilder<bool>(
              stream: _productBloc.outCreated,
              initialData: false,
              builder: (context, snapshot) {
                if (snapshot.data) {
                  return StreamBuilder<bool>(
                      stream: _productBloc.outLoading,
                      initialData: false,
                      builder: (context, snapshot) {
                        return IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: snapshot.data ? null : (){
                              _productBloc.deleteProduct();
                              Navigator.of(context).pop();
                            });
                      });
                } else {
                  return Container();
                }
              },
            ),
            StreamBuilder<bool>(
                stream: _productBloc.outLoading,
                initialData: false,
                builder: (context, snapshot) {
                  return IconButton(
                      icon: Icon(Icons.save),
                      onPressed: snapshot.data ? null : _saveProduct);
                }),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Form(
              key: _formKey,
              child: StreamBuilder<Map>(
                  stream: _productBloc.outData,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return ListView(
                        padding: EdgeInsets.all(16.0),
                        children: <Widget>[
                          Text(
                            "Imagens",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                          ImagesWidget(
                            context: context,
                            initialValue: snapshot.data["images"],
                            onSaved: _productBloc.saveImage,
                            validator: validadeImages,
                          ),
                          TextFormField(
                              initialValue: snapshot.data["title"],
                              style: _fieldStyle,
                              decoration: _buildDecoration("Titulo"),
                              onSaved: _productBloc.saveTitle,
                              validator: validateTitle),
                          TextFormField(
                              initialValue: snapshot.data["description"],
                              style: _fieldStyle,
                              maxLines: 3,
                              decoration: _buildDecoration("Descrição"),
                              onSaved: _productBloc.saveDescription,
                              validator: validateDescription),
                          TextFormField(
                              initialValue:
                                  snapshot.data["price"]?.toStringAsFixed(2),
                              style: _fieldStyle,
                              decoration: _buildDecoration("Preço"),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              onSaved: _productBloc.savePrice,
                              validator: validadePrice),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "Tamanhos",
                            style:
                            TextStyle(color: Colors.white, fontSize: 12.0),
                          ),
                          ProductsSizes(
                            context: context,
                            initialValue: snapshot.data["sizes"],
                            onSaved: _productBloc.saveSizes,
                            validator: (value){
                              if(value.isEmpty){
                                return "Adicione um tamanho";
                              }else{
                                return null;
                              }
                            },
                          )
                        ],
                      );
                    }
                  }),
            ),
            StreamBuilder<bool>(
                stream: _productBloc.outLoading,
                initialData: false,
                builder: (context, snapshot) {
                  return IgnorePointer(
                    ignoring: !snapshot.data,
                    child: Container(
                      color:
                          snapshot.data ? Colors.black54 : Colors.transparent,
                    ),
                  );
                }),
          ],
        ));
  }

  void _saveProduct() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Salvando produto...",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(minutes: 1),
        backgroundColor: Color.fromARGB(255, 240, 80, 83),
      ));

      bool success = await _productBloc.saveProduct();

      _scaffoldKey.currentState.removeCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          success ? "Produto salvo" : "Erro ao salvar",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 240, 80, 83),
      ));
    }
  }
}
