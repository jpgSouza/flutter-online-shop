import 'package:flutter/material.dart';
import 'package:flutter_online_shop/tabs/home_tab.dart';

class HomeActivity extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeTab()
      ],
    );
  }
}
