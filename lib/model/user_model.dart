import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model{

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  static User of(BuildContext context) => ScopedModel.of<User>(context);


  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  void createAccount({@required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFail}){
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass
    ).then((user) async{
      firebaseUser = user;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((err){
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void login({@required String email, @required String password, @required VoidCallback onSuccess, @required VoidCallback onFail}) async{

    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: password).then((user) async{
      firebaseUser = user;

      await _loadCurrentUser();

      onSuccess();
      isLoading = false;
      notifyListeners();

    }).catchError((err){
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }

  void logout() async{
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPassword({@required String email}){
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async{
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    if(firebaseUser != null)
      if(userData["name"] == null){
        DocumentSnapshot docUser = await Firestore.instance.collection("users").document(firebaseUser.uid).get();
        userData = docUser.data;
      }
    notifyListeners();
  }

}