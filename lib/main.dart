import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/activities/home_activity.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/activities/login_activity.dart';
import 'package:flutter_online_shop/model/credit_card_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/cart_model.dart';
import 'model/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<User>(
      model: User(),
      child: ScopedModelDescendant<User>(
        builder: (context, child, model){
          return ScopedModel<Cart>(
            model: Cart(model),
            child: ScopedModel<CreditCard>(
              model: CreditCard(model),
              child: MaterialApp(
                  title: 'Alquingel Store',
                  theme: ThemeData(
                      primarySwatch: Colors.blue,
                      primaryColor: Color.fromARGB(255, 4, 125, 141)
                  ),
                  debugShowCheckedModeBanner: false,
                  home:HomeActivity(),
              ),
            ),
          );
        }
      ),
    );
  }
}

