import 'package:flutter/material.dart';
import 'package:flutter_online_shop/activities/create_account_activity.dart';
import 'package:flutter_online_shop/activities/home_activity.dart';
import 'package:scoped_model/scoped_model.dart';

import 'activities/login_activity.dart';
import 'model/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<User>(
      model: User(),
      child: MaterialApp(
          title: 'Alquingel Store',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Color.fromARGB(255, 4, 125, 141)
          ),
          debugShowCheckedModeBanner: false,
          home:HomeActivity()
      ),
    );
  }
}

