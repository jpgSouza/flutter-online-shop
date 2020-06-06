import 'package:flutter/material.dart';
import 'package:flutter_online_shop/activities/profile_activity.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<User>(
      builder: (context, child, model) {
        if (model.isLoggedIn()) {
          return ProfileActivity();
        } else {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 50, bottom: 50, left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.block,
                  color: Color.fromARGB(255, 240, 80, 83),
                  size: 60,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Faça o login para ver suas informações",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[500], fontSize: 18.0),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
