import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/conta_data.dart';
import '../models/conta.dart';
import '../models/crud.dart';
import '../utils/formatacao_utils.dart';
import '../utils/resultado.dart';
import '../utils/validador_utils.dart';

class ContaCrudContException implements Exception {
  final String mensagem;
  ContaCrudContException(this.mensagem);
}

final contaCrudContProvider =
    ChangeNotifierProvider.family<ContaCrudCont, ContaCrudKey>(
        (ref, contaCrudKey) =>
            ContaCrudCont(ref: ref, contaCrudKey: contaCrudKey));

class ContaCrudCont extends ChangeNotifier {
  final Ref ref;
  ContaCrudKey contaCrudKey;
  final formKey = GlobalKey<FormState>();
  TipoConta? inputTipoConta;
  final inputNome = TextEditingController();
  final inputSaldoInicial = TextEditingController();
  final inputLimiteCredito = TextEditingController();
  bool inputFavorita = false;
  bool inputInativa = false;
  bool isLoading = true;

  ContaCrudCont({required this.ref, required this.contaCrudKey}) {
    _refresh();
  }

  _refresh() async {
    if (contaCrudKey.crud.isNew) {
      inputTipoConta = null;
      inputNome.clear();
      inputSaldoInicial.clear();
      inputLimiteCredito.clear();
      inputFavorita = false;
      inputInativa = false;
    } else {
      ContaData contaData = ref.read(contaDataProvider);
      Conta? conta = await contaData.getContaById(contaCrudKey.contaId!);
      if (conta == null) {
        throw ContaCrudContException(
            'Conta "${contaCrudKey.contaId}" não encontrada!');
      }
      inputTipoConta = conta.tipoConta;
      inputNome.text = conta.nome;
      inputSaldoInicial.text = conta.saldoInicial.toStrForm2Dig();
      inputLimiteCredito.text = conta.limiteCredito?.toStrForm2Dig() ?? '';
      inputFavorita = conta.favorito;
      inputInativa = conta.inativo;
    }
    isLoading = true;
  }

  refresh() async {
    await _refresh();
    notifyListeners();
  }

  setTipoConta(TipoConta tipoConta) {
    inputTipoConta = tipoConta;
    notifyListeners();
  }

  String? validarTipoConta(TipoConta? value) {
    return validarNULL(campo: 'Tipo de conta', valor: value);
  }

  String? validarNome(String? value) {
    return validarCampo(
      campo: 'Nome',
      valor: value,
      regrasDeValidacao: [
        regraValidarVazio,
      ],
    );
  }

  String? validarSaldoInicial(String? value) {
    return validarCampo(
      campo: 'Saldo inicial',
      valor: value,
      regrasDeValidacao: [
        regraValidarDec2DigSinal,
      ],
    );
  }

  String? validarLimiteCredito(String? value) {
    return validarCampo(
      campo: 'Limite de crédito',
      valor: value,
      regrasDeValidacao: [
        regraValidarDec2DigSinal,
      ],
    );
  }

  setFavorita(bool? value) {
    inputFavorita = value ?? false;
    notifyListeners();
  }

  setInativa(bool? value) {
    inputInativa = value ?? false;
    notifyListeners();
  }

  Future<Resultado> persistir() async {
    if (contaCrudKey.crud.isAction) {
      ContaData contaData = ref.read(contaDataProvider);
      if (contaCrudKey.crud == Crud.delete) {
        return contaData.eliminarConta(contaId: contaCrudKey.contaId!);
      } else {
        if (contaCrudKey.crud == Crud.create) {
          return await contaData.criarConta(
            tipoConta: inputTipoConta!,
            nome: inputNome.text,
            saldoInicial: inputSaldoInicial.text.fromStrFormatado() ?? 0,
            limiteCredito: inputLimiteCredito.text.fromStrFormatado(),
            favorito: inputFavorita,
            inativo: inputInativa,
          );
        } else {
          return await contaData.alterarConta(
            conta: Conta(
              contaId: contaCrudKey.contaId,
              tipoConta: inputTipoConta!,
              nome: inputNome.text,
              saldoInicial: inputSaldoInicial.text.fromStrFormatado() ?? 0,
              limiteCredito: inputLimiteCredito.text.fromStrFormatado(),
              favorito: inputFavorita,
              inativo: inputInativa,
            ),
          );
        }
      }
    } else {
      return Resultado(validado: false);
    }
  }
}
