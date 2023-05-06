import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../databases/db_firestore.dart';
import '../models/conta.dart';
import '../utils/resultado.dart';
import 'path_ref.dart';

final contaDataProvider = Provider<ContaData>((_) => ContaData());

class ContaData {
  Future<Resultado> criarConta({
    required TipoConta tipoConta,
    String? contaId,
    required String nome,
    double saldoInicial = 0,
    bool favorito = false,
    bool inativo = false,
  }) async {
    Resultado resultado = Resultado(validado: true);
    Conta conta = Conta(
      tipoConta: tipoConta,
      contaId: contaId,
      nome: nome,
      saldoInicial: saldoInicial,
      favorito: favorito,
      inativo: inativo,
    );
    FirebaseFirestore db = await DBFirestore.get();
    await PathRef.docRefContaById(db, conta.contaId)
        .set(conta.toMap())
        .then((value) {
      resultado = Resultado(
        mensagem: 'Conta criada com sucesso!',
      );
    }).catchError((erro) {
      resultado = Resultado(
        erro: true,
        mensagem: erro.toString(),
      );
    });
    return resultado;
  }

  Future<Resultado> alterarConta({required Conta conta}) async {
    Resultado resultado = Resultado(validado: true);
    FirebaseFirestore db = await DBFirestore.get();
    await PathRef.docRefContaById(db, conta.contaId)
        .set(conta.toMap())
        .then((value) {
      resultado = Resultado(
        mensagem: 'Conta alterada com sucesso!',
      );
    }).catchError((erro) {
      resultado = Resultado(
        erro: true,
        mensagem: erro.toString(),
      );
    });
    return resultado;
  }

  Future<Resultado> eliminarConta({required String contaId}) async {
    Resultado resultado = Resultado(validado: true);
    FirebaseFirestore db = await DBFirestore.get();
    await PathRef.docRefContaById(db, contaId).delete().then((value) {
      resultado = Resultado(
        mensagem: 'Conta eliminada com sucesso!',
      );
    }).catchError((erro) {
      resultado = Resultado(
        erro: true,
        mensagem: erro.toString(),
      );
    });
    return resultado;
  }

  Future<List<Conta>> listarTodas() async {
    List<Conta> result = [];
    FirebaseFirestore db = await DBFirestore.get();
    await PathRef.colRefContas(db).get().then((value) {
      for (var doc in value.docs) {
        result.add(Conta.fromMap(doc.data()));
      }
    }).catchError((e) {
      if (kDebugMode) {
        print('ContaData.listarTodas-${e.toString()}');
      }
    });
    return result;
  }

  Future<Conta?> getContaById(String contaId) async {
    Conta? result;
    FirebaseFirestore db = await DBFirestore.get();
    await PathRef.docRefContaById(db, contaId).get().then((value) {
      if (value.exists) {
        result = Conta.fromMap(value.data()!);
      }
    }).catchError((_) {});
    return result;
  }
}
