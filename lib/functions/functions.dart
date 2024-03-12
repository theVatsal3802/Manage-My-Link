import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manage_my_link/utils/constants.dart';

class Functions {
  static Future<bool> addLink({
    required String name,
    required String link,
    String? imageUrl,
  }) async {
    try {
      await FirebaseFirestore.instance.collection(Constants.linkCollection).add(
        {
          "name": name,
          "link": link,
          "imageUrl": imageUrl,
          "user": FirebaseAuth.instance.currentUser!.uid
        },
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteLink({
    required String id,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(Constants.linkCollection)
          .doc(id)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
