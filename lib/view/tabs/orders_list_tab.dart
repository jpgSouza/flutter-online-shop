import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/controller/bloc/orders_bloc.dart';
import 'file:///C:/Users/joao_/OneDrive/Documentos/Git-Projects/flutter-online-shop/lib/view/tiles/order_list_tile.dart';


class OrdersListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _ordersBloc = BlocProvider.of<OrdersBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: StreamBuilder<List>(
        stream: _ordersBloc.outOrders,
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if (snapshot.data.length == 0){
            return Center(
              child: Text("Nenhum pedido"),
            );
          }else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return OrderListTile(snapshot.data[index]);
              },
            );
          }
        },
      )
    );
  }
}
