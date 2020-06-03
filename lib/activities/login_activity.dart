import 'package:flutter/cupertino.dart';
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
          backgroundColor: Color.fromRGBO(240, 80, 83,0.7),
          elevation: 2.0,
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
                padding: EdgeInsets.all(0.0),
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 253, 228),
                              Color.fromARGB(255, 240, 80, 83),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              blurRadius: 10.0,
                              offset: Offset(0, 6)
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        )),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          width: MediaQuery.of(context).size.width*0.7,
                          height: 300.0,
                          left: MediaQuery.of(context).size.width/6.0,
                          top: MediaQuery.of(context).size.height*0.0001,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('lib/images/alquingel_logo.png'),
                                fit: BoxFit.fill,
                              )
                            ),
                          ),
                        ),
                        Positioned(
                          left: 30,
                          width: 70,
                          height: 140,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('lib/images/light-1.png'),
                                    fit: BoxFit.fill,
                                )
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 135,
                          left: 280,
                          width: 60,
                          height: 120,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('lib/images/light-2.png'),
                                  fit: BoxFit.fill,
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(240, 80, 83, 0.5),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  //USAR MAIS TARDE
                                  controller: model.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (text) {
                                    if (text.isEmpty || !text.contains("@"))
                                      return "E-mail inválido";
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Color.fromRGBO(240, 80, 83, 0.7),
                                      ),
                                      hintText: "E-mail",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  //USAR MAIS TARDE
                                  controller: model.passwordController,
                                  validator: (text) {
                                    if (text.isEmpty || text.length < 6)
                                      return "Senha inválida";
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: Color.fromRGBO(240, 80, 83, 0.7),
                                    ),
                                    hintText: "Senha",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400]),
                                    suffixIcon: IconButton(
                                      onPressed: () {

                                      },
                                      icon: Icon(Icons.visibility_off, color:Color.fromRGBO(240, 80, 83, 0.7),),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (model.emailController.text.isEmpty)
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(
                                      "Insira seu e-mail para recuperação"),
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                ));
                              else {
                                model.recoverPassword(
                                    email: model.emailController.text);
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("Confira seu e-mail"),
                                  backgroundColor:
                                      Color.fromARGB(255, 0, 90, 163),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                            child: Text(
                              "Esqueci minha senha",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.bold
                              ),
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
                                        Color.fromARGB(255, 255, 253, 228),
                                        Color.fromARGB(255, 240, 80, 83),
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 400.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              )),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => CreateAccountActivity()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Não possui conta?", textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.bold
                                ),),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text("Cadastre-se!", textAlign: TextAlign.center, style: TextStyle(
                                  color: Color.fromARGB(255, 240, 80, 83),
                                  fontWeight: FontWeight.bold
                                ),)
                              ],
                            )
                          ),
                        ),
                      ],
                    ),
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
