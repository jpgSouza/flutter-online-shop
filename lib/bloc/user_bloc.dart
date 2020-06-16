import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase{

  final _usersController = BehaviorSubject<List>();

  Map<String, Map<String, dynamic>> _users = Map();

  Firestore _firestore = Firestore.instance;

  UserBloc(){
    _addUsersListener();
  }

  void _addUsersListener(){
    _firestore.collection("users").snapshots().listen((snapshot){
      snapshot.documentChanges.forEach((change) {
        String uid = change.document.documentID;
        switch(change.type){
          case DocumentChangeType.added:
            _users[uid] = change.document.data;
            break;
          case DocumentChangeType.modified:
            _users[uid].addAll(change.document.data);
            break;
          case DocumentChangeType.removed:
            _users[uid].remove(uid);
            break;
        }
      });

      _usersController.add(_users.values.toList());

    });
  }

  @override
  void dispose() {
    _usersController.close();
  }

  Map<String, dynamic> getUserInfo(String uid){
    print(_users.length);
    return _users[uid];
  }


}