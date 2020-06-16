import 'package:flutter/material.dart';
import 'package:flutter_online_shop/activities/cart_activity.dart';
import 'package:flutter_online_shop/model/user_model.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 4.0,
      child: Icon(Icons.shopping_cart, color: Colors.white,),
      onPressed: (){
        User.of(context).logout();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CartActivity())
        );
      },
      backgroundColor: Color.fromARGB(255, 240, 80, 83),
    );
  }
}
