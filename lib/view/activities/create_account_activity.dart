import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/controller/data/cep_data.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/controller/data/cep_service_data.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateAccountActivity extends StatefulWidget {
  @override
  _CreateAccountActivityState createState() => _CreateAccountActivityState();
}

class _CreateAccountActivityState extends State<CreateAccountActivity> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loading = false;

  CepData _cepData;

  String _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(240, 80, 83, 0.7),
          elevation: 2.0,
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
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 80, 83),
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(Icons.person,
                            color: Color.fromRGBO(240, 80, 83, 0.7)),
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
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 80, 83),
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(Icons.email,
                            color: Color.fromRGBO(240, 80, 83, 0.7)),
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
                            if (text.isEmpty)
                              return "CPF inválido";
                          },
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 240, 80, 83),
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              prefixIcon: Icon(Icons.person_pin_circle,
                                  color: Color.fromRGBO(240, 80, 83, 0.7)),
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
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 240, 80, 83),
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                prefixIcon: Icon(Icons.face,
                                    color: Color.fromRGBO(240, 80, 83, 0.7)),
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
                      if (text.isEmpty || text.length != 12)
                        return "Telefone inválido";
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 80, 83),
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(Icons.phone,
                            color: Color.fromRGBO(240, 80, 83, 0.7)),
                        hintText: "Telefone"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: model.searchCEP,
                    validator: (text) {
                      if (text.isEmpty) return "CEP inváilido";
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 80, 83),
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        prefixIcon: Icon(Icons.my_location,
                            color: Color.fromRGBO(240, 80, 83, 0.7)),
                        suffixIcon: IconButton(
                          icon: _loading
                              ? CircularProgressIndicator()
                              : Icon(
                                  Icons.search,
                                  color: Color.fromRGBO(240, 80, 83, 0.7),
                                ),
                          onPressed: () {
                            _searchCep(model);
                          },
                        ),
                        hintText: "CEP"),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildResultForm(),
                  TextFormField(
                    controller: model.passwordController,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha inválida";
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 240, 80, 83),
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: "Senha",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(Icons.lock,
                          color: Color.fromRGBO(240, 80, 83, 0.7)),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.visibility_off,
                            color: Color.fromRGBO(240, 80, 83, 0.7)),
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
                          "cep": model.cep,
                          "uf": model.uf,
                          "street": model.street,
                          "distric": model.district,
                          "locality": model.locality,
                          "number": model.addressNumberController.text
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
                                  Color.fromARGB(255, 255, 253, 228),
                                  Color.fromARGB(255, 240, 80, 83),
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

  Future _searchCep(User user) async {
    _searching(true);

    final cep = user.searchCEP.text;

    _cepData = await CepService.fetchCep(cep: cep);

    setState(() {
      _result = _cepData.toJson();
    });

    user.cep = _cepData.cep;
    user.locality = _cepData.locality;
    user.district = _cepData.district;
    user.uf = _cepData.uf;
    user.street = _cepData.street;

    _searching(false);
  }

  void _searching(bool enable) {
    setState(() {
      _result = enable ? '' : _result;
      _loading = enable;
    });
  }

  Widget _buildResultForm() {
    return _result == null || _loading == true
        ? Container()
        : Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 240, 80, 83),
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: "${_cepData.locality}",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon:
                          Icon(Icons.home, color: Color.fromRGBO(240, 80, 83, 0.7)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    width: 100,
                    child: TextField(
                      textAlign: TextAlign.center,
                      enabled: false,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 80, 83),
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: "${_cepData.uf}",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 240, 80, 83),
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: "${_cepData.street}",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Icon(Icons.location_on,
                              color: Color.fromRGBO(240, 80, 83, 0.7)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    width: 100,
                    child: TextFormField(
                      controller: User.of(context).addressNumberController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 80, 83),
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: "n°",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 240, 80, 83),
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: "${_cepData.district}",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  prefixIcon:
                  Icon(Icons.near_me, color: Color.fromRGBO(240, 80, 83, 0.7)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          );
  }
}
