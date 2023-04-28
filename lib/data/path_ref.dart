import 'package:cloud_firestore/cloud_firestore.dart';

class PathRef {
  static DocumentReference<Map<String, dynamic>> docRefUsuarioById(
      FirebaseFirestore db, String userId) {
    return db.collection('usuarios').doc(userId);
  }
}
