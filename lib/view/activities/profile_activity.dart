import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/widgets/profile_card.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<User>(builder: (context, child, model) {
      if (model.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(14.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.0,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        blurRadius: 10.0,
                        offset: Offset(0, 6))
                  ],
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.3),
                              blurRadius: 10.0,
                              offset: Offset(0, 6))
                        ],
                        borderRadius: BorderRadius.circular(80.0)),
                    margin: EdgeInsets.all(20.0),
                    width: 120.0,
                    height: 120.0,
                    child: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('lib/images/avatar.png')),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "${model.userData["name"]}",
                    style: TextStyle(
                        color: Color.fromRGBO(240, 80, 83, 0.6),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "${model.userData["email"]}",
                    style: TextStyle(
                        color: Color.fromRGBO(240, 80, 83, 0.6),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            ProfileCard(),
            SizedBox(
              height: 6.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 40.0, right: 40.0),
              child: RaisedButton(
                onPressed: () {
                  model.deleteProfile();
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
                        "Deletar Conta",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
            )
          ],
        );
      }
    });
  }
}
