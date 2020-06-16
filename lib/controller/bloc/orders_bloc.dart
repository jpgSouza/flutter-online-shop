import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

enum SortOrders { READY_FIRST, READY_LAST }

class OrdersBloc extends BlocBase {
  final _ordersController = BehaviorSubject<List>();

  Stream<List> get outOrders => _ordersController.stream;

  Firestore _firestore = Firestore.instance;

  List<DocumentSnapshot> _orders = [];

  SortOrders _sortOrders;

  OrdersBloc() {
    _addOrdersListener();
  }

  void _addOrdersListener() {
    _firestore.collection("orders").snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String oid = change.document.documentID;

        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(change.document);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((order) => order.documentID == oid);
            _orders.add(change.document);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((order) => order.documentID == oid);
            break;
        }
      });

      _sort();
    });
  }

  void setOrderSort(SortOrders sortOrders) {
    _sortOrders = sortOrders;
    _sort();
  }

  void _sort() {
    switch (_sortOrders) {
      case SortOrders.READY_FIRST:
        _orders.sort((a, b) {
          int statusA = a.data["status"];
          int statusB = b.data["status"];

          if (statusA < statusB)
            return 1;
          else if (statusA > statusB)
            return -1;
          else
            return 0;
        });
        break;
      case SortOrders.READY_LAST:
        _orders.sort((a, b) {
          int statusA = a.data["status"];
          int statusB = b.data["status"];

          if (statusA > statusB)
            return 1;
          else if (statusA < statusB)
            return -1;
          else
            return 0;
        });
        break;
    }
    _ordersController.add(_orders);
  }

  @override
  void dispose() {
    _ordersController.close();
  }
}
