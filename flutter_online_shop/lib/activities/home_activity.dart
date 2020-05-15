import 'package:flutter/material.dart';
import 'package:flutter_online_shop/tabs/home_tab.dart';
import 'package:flutter_online_shop/widgets/custom_drawer.dart';

class HomeActivity extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(),
        )
      ],
    );
  }
}
