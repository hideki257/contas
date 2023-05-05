import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/user_auth_cont.dart';

class PathRef {
  static DocumentReference<Map<String, dynamic>> docRefUsuarioById(
      FirebaseFirestore db, String userId) {
    return db.collection('usuarios').doc(userId);
  }

  static CollectionReference<Map<String, dynamic>> colRefUsuarios(
      FirebaseFirestore db) {
    return db.collection('usuarios');
  }

  static DocumentReference<Map<String, dynamic>> docRefContaById(
      FirebaseFirestore db, String contaId) {
    return db
        .collection('dados')
        .doc(UserAuthCont.usuarioId)
        .collection('contas')
        .doc(contaId);
  }

  static CollectionReference<Map<String, dynamic>> colRefContas(
      FirebaseFirestore db) {
    return db
        .collection('dados')
        .doc(UserAuthCont.usuarioId)
        .collection('contas');
  }
}
