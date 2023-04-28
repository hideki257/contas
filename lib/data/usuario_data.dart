import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../databases/db_firestore.dart';
import '../models/usuario.dart';
import '../utils/resultado.dart';
import 'path_ref.dart';

class UsuarioDataExeption implements Exception {
  final String message;
  UsuarioDataExeption(this.message);
}

final usuarioDataProvider =
    Provider.autoDispose<UsuarioData>((_) => UsuarioData());

class UsuarioData {
  Future<Resultado> criarUsuario({
    required String userId,
    required String email,
    String? nome,
    DateTime? dataNascimento,
  }) async {
    Resultado? result;
    FirebaseFirestore db = await DBFirestore.get();
    await PathRef.docRefUsuarioById(db, userId)
        .set(Usuario(
                userId: userId,
                email: email,
                nome: nome,
                dataNascimento: dataNascimento)
            .toMap())
        .catchError((e) {
      result = Resultado(erro: true, mensagem: e.toString());
    });
    return result ?? Resultado();
  }

  Future<Resultado> alterarUsuario({required Usuario usuario}) async {
    Resultado? result;
    FirebaseFirestore db = await DBFirestore.get();
    await PathRef.docRefUsuarioById(db, usuario.userId)
        .set(usuario.toMap())
        .catchError((e) {
      result = Resultado(erro: true, mensagem: e.toString());
    });
    return result ?? Resultado();
  }

  Future<Resultado> apagarUsuario({required String userId}) async {
    Resultado? result;
    FirebaseFirestore db = await DBFirestore.get();
    await PathRef.docRefUsuarioById(db, userId).delete().catchError((e) {
      result = Resultado(erro: true, mensagem: e.toString());
    });
    return result ?? Resultado();
  }

  Future<Usuario> getUsuarioById({required String userId}) async {
    Usuario? result;
    String erro = '';
    FirebaseFirestore db = await DBFirestore.get();
    await PathRef.docRefUsuarioById(db, userId).get().then((value) {
      if (value.exists) {
        result = Usuario.fromMap(value.data()!);
      }
    }).catchError((e) {
      erro = e.toString();
    });
    if (result != null) {
      return result!;
    } else {
      throw UsuarioDataExeption(erro);
    }
  }
}
