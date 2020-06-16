import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/tabs/home_tab.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/tabs/products_tab.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/tabs/profile_tab.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/widgets/cart_button.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/widgets/custom_drawer.dart';

import '../tabs/orders_tab.dart';

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
        Scaffold(
          appBar: AppBar(
            title: Text("Meu Pedidos"),
            elevation: 8.0,
            backgroundColor: Color.fromRGBO(240, 80, 83,0.7),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: OrdersTab(),
        )
      ],
    );
  }
}
