import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final google = GoogleSignIn.instance;
      await google.initialize();
      final account = await google.authenticate();
      final auth = account.authentication;
      final credential = GoogleAuthProvider.credential(idToken: auth.idToken);
      return await _auth.signInWithCredential(credential);
    } catch (_) {
      return null;
    }
  }

  Future<UserCredential?> signInWithEmail(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } catch (_) {
      return null;
    }
  }

  Future<UserCredential?> registerWithEmail(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
  }
}
