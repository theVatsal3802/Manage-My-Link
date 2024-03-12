import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manage_my_link/utils/constants.dart';

class AuthFunctions {
  static Future<String> authenticate({
    String? name,
    required String email,
    required String password,
    required bool isLogin,
  }) async {
    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then(
          (value) {
            Map<String, dynamic> data = {
              "name": name,
              "email": email,
              "links": [],
            };
            FirebaseFirestore.instance
                .collection(Constants.userCollection)
                .doc(value.user!.uid)
                .set(data);
          },
        );
      }
      return "Success";
    } on FirebaseAuthException catch (e) {
      var msg = "Something went wrong";
      if (e.code == "invalid-email") {
        msg = "Invalid email";
      } else if (e.code == "user-not-found") {
        msg = "Accoutn not found, Ask Admin to create one";
      } else if (e.code == "user-disabled") {
        msg = "Your account has been disabled by admin";
      } else if (e.code == "wrong-password") {
        msg = "Wrong password";
      } else if (e.code == "email-already-in-use") {
        msg = "Email is already in use, please enter some other email ID";
      }
      return msg;
    } catch (e) {
      return "Something went wrong, please try again";
    }
  }
}
