import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_ar/screens/home_screen.dart';

//**
//? Klasa odpowiedzialna za dostarczanie oraz zarządzanie stanem autoryzacji
//? w naszej aplikacji. Korzystamy w niej z metod biblioteki Firebase_Auth
//? pobieramy strumień przy pomocy metody _firebaseAuth.idTokenChanges()
//? i dzięki nasłuchowi w providerze w innych ekranach aplikacji wiemy o kazdej
//? zmianie stanu (uzytkownik loguje się, wylogowuje się).
//? Mamy tu równiez metody do rejestracji, logowania oraz wylogowania się
//? z aplikacji.
// */

class AuthProvider {
  final FirebaseAuth _firebaseAuth;

  AuthProvider(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }

  Future<String?> signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }
}
