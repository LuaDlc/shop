
// import 'package:firebase/firebase.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthRepository {
//   final FirebaseAuth _firebaseAuth;

//   AuthRepository() : _firebaseAuth = FirebaseAuth.instance;

  

//   Future<User?> signUpWithEmailAndPassword(String email, String password) async {
//     try {
//       final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       // Handle sign-up error
//       print('Sign-up error: $e');
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }

//   User? getCurrentUser() {
//     return _firebaseAuth.currentUser;
//   }
// }