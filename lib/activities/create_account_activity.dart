import 'package:flutter/material.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateAccountActivity extends StatefulWidget {
  @override
  _CreateAccountActivityState createState() => _CreateAccountActivityState();
}

class _CreateAccountActivityState extends State<CreateAccountActivity> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<User>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(32.0),
                children: <Widget>[
                  TextFormField(
                    controller: model.nameController,
                    keyboardType: TextInputType.text,
                    validator: (text) {
                      if (text.isEmpty) return "Nome inválido";
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(Icons.person),
                        hintText: "Nome Completo"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: model.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail inválido";
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(Icons.email),
                        hintText: "E-mail"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Container(
                        width: 200.0,
                        child: TextFormField(
                          controller: model.cpfController,
                          keyboardType: TextInputType.number,
                          validator: (text) {
                            if (text.isEmpty) return "CPF inválido";
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              prefixIcon: Icon(Icons.person_pin_circle),
                              hintText: "CPF"),
                        ),
                      )),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: 50.0),
                          width: 200.0,
                          child: TextFormField(
                            controller: model.genderController,
                            keyboardType: TextInputType.text,
                            validator: (text) {
                              if (text.isEmpty) return "Sexo inválido";
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefixIcon: Icon(Icons.face),
                                hintText: "Sexo"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: model.phoneController,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text.isEmpty) return "Telefone inválido";
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(Icons.phone),
                        hintText: "Telefone"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: model.addressController,
                    validator: (text) {
                      if (text.isEmpty) return "Endereço inválido";
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(Icons.home),
                        hintText: "Endereço"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: model.passwordController,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha inválida";
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Senha",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": model.nameController.text,
                          "email": model.emailController.text,
                          "cpf": model.cpfController.text,
                          "gender": model.genderController.text,
                          "phone": model.phoneController.text,
                          "address": model.addressController.text
                        };
                        model.createAccount(
                            userData: userData,
                            pass: model.passwordController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 44, 62, 80),
                                  Color.fromARGB(255, 76, 161, 175),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 400.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Criar Conta",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Cadastro realizado com sucesso!"),
      backgroundColor: Color.fromARGB(255, 0, 90, 163),
      duration: Duration(seconds: 2),
    ));

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao cadastrar"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
