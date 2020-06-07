import 'package:flutter/material.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:flutter_online_shop/widgets/profile_card.dart';
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
                borderRadius: BorderRadius.circular(8.0)
              ),
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
                    "${User.of(context).userData["name"]}",
                    style: TextStyle(
                        color: Color.fromRGBO(240, 80, 83, 0.6),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "${User.of(context).userData["email"]}",
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
          ],
        );
      }
    });
  }
}
