import 'package:flutter/material.dart';
import 'package:flutter_online_shop/activities/create_account_activity.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginActivity extends StatefulWidget {
  @override
  _LoginActivityState createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => CreateAccountActivity()));
              },
            ),
          ],
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        if (model.emailController.text.isEmpty)
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Insira seu e-mail para recuperação"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ));
                        else {
                          model.recoverPassword(
                              email: model.emailController.text);
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Confira seu e-mail"),
                            backgroundColor: Color.fromARGB(255, 0, 90, 163),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                      model.login(
                        email: model.emailController.text,
                        password: model.passwordController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail,
                      );
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
                            "Login",
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
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao logar"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
