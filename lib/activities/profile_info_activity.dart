import 'package:flutter/material.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileInfoActivity extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Text("Informações Gerais"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(240, 80, 83, 0.7),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.mode_edit),
              color: Colors.white,
              onPressed: () {
              },
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<User>(
        builder: (context, child, model) {
          return Form(
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
                        enabled: false,
                        initialValue: model.userData["name"],
                        decoration: InputDecoration(
                          labelText: "Nome",
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: model.userData["email"],
                        decoration: InputDecoration(
                          labelText: "E-mail",
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: model.userData["cpf"],
                        decoration: InputDecoration(
                          labelText: "CPF",
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: model.userData["phone"],
                        decoration: InputDecoration(
                          labelText: "Telefone",
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      RaisedButton(
                        onPressed: () {},
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

}
