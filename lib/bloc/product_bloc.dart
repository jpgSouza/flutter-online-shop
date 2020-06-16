import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  String categoryID;
  DocumentSnapshot documentSnapshot;

  final _dataController = BehaviorSubject<Map>();

  Stream<Map> get outData => _dataController.stream;


  Map<String, dynamic> unsavedData;


  ProductBloc({this.categoryID, this.documentSnapshot}){
    if(documentSnapshot != null){
      unsavedData = Map.of(documentSnapshot.data);
      unsavedData["images"] = List.of(documentSnapshot.data["images"]);
      unsavedData["sizes"] = List.of(documentSnapshot.data["sizes"]);
    }else{
      unsavedData = {
        "title": null,
        "description": null,
        "price": null,
        "images": [],
        "sizes": []
      };
    }
    _dataController.add(unsavedData);
  }

  @override
  void dispose() {
    _dataController.close();
  }
}
