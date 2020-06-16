import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_online_shop/bloc/orders_bloc.dart';
import 'package:flutter_online_shop/bloc/user_bloc.dart';
import 'package:flutter_online_shop/model/user_model.dart';
import 'package:flutter_online_shop/tabs/orders_list_tab.dart';
import 'package:flutter_online_shop/tabs/products_list_tab.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AdminActivity extends StatefulWidget {
  @override
  _AdminActivityState createState() => _AdminActivityState();
}

class _AdminActivityState extends State<AdminActivity> {
  PageController _pageController;
  int _page = 0;

  OrdersBloc _ordersBloc;
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _ordersBloc = OrdersBloc();
    _userBloc = UserBloc();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
          onTap: (pageIndex) {
            _pageController.animateToPage(pageIndex,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
            if(pageIndex == 2){
              User.of(context).logout();
              Navigator.of(context).pop();
            }
          },
          unselectedItemColor: Colors.grey[850],
          selectedItemColor: Colors.white,
          elevation: 5.0,
          backgroundColor: Color.fromARGB(255, 240, 80, 83),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text("Pedidos")),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted),
                title: Text("Produtos")),
            BottomNavigationBarItem(
                icon: Icon(Icons.exit_to_app), title: Text("Sair")),
          ]),
      body: SafeArea(
        child: BlocProvider<UserBloc>(
          bloc: _userBloc,
          child: BlocProvider<OrdersBloc>(
            bloc: _ordersBloc,
            child:PageView(
                onPageChanged: (pageIndex){
                  setState(() {
                    _page = pageIndex;
                  });
                },
                controller: _pageController,
                children: <Widget>[
                  OrdersListTab(),
                  ProductsListTab(),
                ],
              ),
          )
        )
      ),
      floatingActionButton: _buildFloatActionButton(),
    );
  }

  Widget _buildFloatActionButton(){
    switch(_page){
      case 0:
        return SpeedDial(
          child: Icon(Icons.sort),
          backgroundColor: Color.fromARGB(255, 240, 80, 83),
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              child: Icon(Icons.arrow_downward, color: Colors.white,),
              backgroundColor: Color.fromARGB(210, 240, 80, 83),
              label: "Entregues Abaixo",
              labelStyle: TextStyle(fontSize: 14.0),
              onTap: (){
                _ordersBloc.setOrderSort(SortOrders.READY_LAST);
              }
            ),
            SpeedDialChild(
                child: Icon(Icons.arrow_upward, color: Colors.white,),
                backgroundColor: Color.fromARGB(210, 240, 80, 83),
                label: "Entregues Acima",
                labelStyle: TextStyle(fontSize: 14.0),
                onTap: (){
                  _ordersBloc.setOrderSort(SortOrders.READY_FIRST);
                }
            )
          ],
        );
        break;

      case 1:
        return null;
        break;
    }
  }
}
