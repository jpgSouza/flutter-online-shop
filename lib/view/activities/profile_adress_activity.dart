import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileAdressActivity extends StatefulWidget {
  @override
  _ProfileAdressActivityState createState() => _ProfileAdressActivityState();
}

class _ProfileAdressActivityState extends State<ProfileAdressActivity> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _enableField = false;

  String cep;
  String district;
  String locality;
  String street;
  String number;
  String uf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 4.0,
        title: Text("Endereço de Cobrança"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(240, 80, 83, 0.7),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.mode_edit),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _enableField = true;
                });
              },
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<User>(
        builder: (context, child, model) {
          return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(30.0),
                  margin: EdgeInsets.all(14.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            blurRadius: 10.0,
                            offset: Offset(0, 6))
                      ],
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Entre com um CEP válido';
                            }
                          },
                          enabled: _enableField,
                          initialValue: model.userData["cep"],
                          decoration: InputDecoration(
                            labelText: "CEP",
                          ),
                          onSaved: (value) {
                            cep = value;
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty ) {
                                    return "Cidade Inválida";
                                  }
                                },
                                enabled: _enableField,
                                initialValue: model.userData["locality"],
                                decoration: InputDecoration(
                                  labelText: "Cidade",
                                ),
                                onSaved: (value) {
                                  locality = value;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Container(
                            width: 100.0,
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty || value.length != 2) {
                                  return "UF Inválido";
                                }
                              },
                              enabled: _enableField,
                              initialValue: model.userData["uf"],
                              decoration: InputDecoration(
                                labelText: "UF",
                              ),
                              onSaved: (value) {
                                uf = value;
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Rua Inválida";
                                  }
                                },
                                enabled: _enableField,
                                initialValue: model.userData["street"],
                                decoration: InputDecoration(
                                  labelText: "Rua",
                                ),
                                onSaved: (value) {
                                  street = value;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Container(
                            width: 100.0,
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Número Inválido";
                                }
                              },
                              enabled: _enableField,
                              initialValue: model.userData["number"],
                              decoration: InputDecoration(
                                labelText: "n°",
                              ),
                              onSaved: (value) {
                                number = value;
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Bairro Inválido";
                          }
                        },
                        enabled: _enableField,
                        initialValue: model.userData["distric"],
                        decoration: InputDecoration(
                          labelText: "Bairro",
                        ),
                        onSaved: (value) {
                          district = value;
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            Map<String, dynamic> userData = {
                              "distric": district,
                              "locality": locality,
                              "street": street,
                              "uf": uf,
                              "number": number,
                              "cep": cep,
                            };

                            model.editProfile(
                              userData: userData,
                              onSuccess: _onSuccess,
                            );
                            setState(() {
                              _enableField = false;
                            });
                          }
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
                              constraints: BoxConstraints(
                                  maxWidth: 400.0, minHeight: 40.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Salvar",
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
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "Dados atualizados",
        textAlign: TextAlign.center,
      ),
      backgroundColor: Color.fromARGB(255, 0, 90, 163),
      duration: Duration(seconds: 2),
    ));
  }

}
