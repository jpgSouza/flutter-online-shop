import 'package:flutter/material.dart';
import 'package:flutter_online_shop/tabs/home_tab.dart';
import 'package:flutter_online_shop/tabs/products_tab.dart';
import 'package:flutter_online_shop/tabs/profile_tab.dart';
import 'package:flutter_online_shop/widgets/cart_button.dart';
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
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            elevation: 8.0,
            backgroundColor: Color.fromRGBO(240, 80, 83,0.7),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Perfil"),
            elevation: 8.0,
            backgroundColor: Color.fromRGBO(240, 80, 83,0.7),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProfileTab(),
        ),
      ],
    );
  }
}
