import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
  String categoryID;
  DocumentSnapshot documentSnapshot;

  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();

  Stream<Map> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  Map<String, dynamic> unsavedData;

  ProductBloc({this.categoryID, this.documentSnapshot}) {
    if (documentSnapshot != null) {
      unsavedData = Map.of(documentSnapshot.data);
      unsavedData["images"] = List.of(documentSnapshot.data["images"]);
      unsavedData["sizes"] = List.of(documentSnapshot.data["sizes"]);

      _createdController.add(true);

    } else {
      unsavedData = {
        "title": null,
        "description": null,
        "price": null,
        "images": [],
        "sizes": []
      };
      _createdController.add(false);
    }
    _dataController.add(unsavedData);
  }

  void saveTitle(String title) {
    unsavedData["title"] = title;
  }

  void saveDescription(String description) {
    unsavedData["description"] = description;
  }

  void savePrice(String price) {
    unsavedData["price"] = double.parse(price);
  }

  void saveImage(List images) {
    unsavedData["images"] = images;
  }

  void saveSizes(List sizes) {
    unsavedData["sizes"] = sizes;
  }

  @override
  void dispose() {
    _dataController.close();
    _loadingController.close();
    _createdController.close();
  }

  Future<bool> saveProduct() async {
    _loadingController.add(true);

    try {
      if (documentSnapshot != null) {
        await _uploadImages(documentSnapshot.documentID);
        await documentSnapshot.reference.updateData(unsavedData);
      } else {
        DocumentReference reference = await Firestore.instance.collection("products")
            .document(categoryID)
            .collection("items")
            .add(Map.from(unsavedData)
          ..remove("images"));
        await _uploadImages(reference.documentID);
        await reference.updateData(unsavedData);
      }
      _createdController.add(true);
      _loadingController.add(false);
      return true;
    } catch (err) {
      _loadingController.add(false);
      return false;
    }
  }

  Future _uploadImages(String pid) async {
    for (int i = 0; i < unsavedData["images"].length; i++) {
      if (unsavedData["images"][i] is String) continue;

      StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(categoryID)
          .child(pid)
          .child(DateTime
          .now()
          .millisecondsSinceEpoch
          .toString())
          .putFile(unsavedData["images"][i]);

      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String URL = await taskSnapshot.ref.getDownloadURL();

      unsavedData["images"][i] = URL;
    }
  }

  void deleteProduct(){
    documentSnapshot.reference.delete();
  }

}
