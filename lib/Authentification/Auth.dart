import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
    await FirebaseAuth.instance.currentUser?.reload() ;

  }

  Future<void> signInUserWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
