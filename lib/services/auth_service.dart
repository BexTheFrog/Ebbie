import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  //Cadastro
  Future<User?> signUp(String email, String senha) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
    return cred.user;
  }

  // Login
  Future<User?> signIn(String email, String senha) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
    return cred.user;
  }

  // Log Out
  Future<void> signOut() async => await _auth.signOut();
}
