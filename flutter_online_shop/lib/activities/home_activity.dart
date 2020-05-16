import 'package:flutter/material.dart';
import 'package:flutter_online_shop/tabs/home_tab.dart';
import 'package:flutter_online_shop/tabs/products_tab.dart';
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
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            elevation: 8.0,
            backgroundColor: Color.fromARGB(255, 0, 90, 163),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),
      ],
    );
  }
}
