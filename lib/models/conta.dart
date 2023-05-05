import 'package:uuid/uuid.dart';

class ContaException implements Exception {
  final String mensagem;
  ContaException(this.mensagem);
}

enum TipoConta { ctaCorr, crtCred, ctaDebt }

extension TipoContaExt on TipoConta {
  String _toDescr() {
    switch (this) {
      case TipoConta.ctaCorr:
        return 'Conta corrente';
      case TipoConta.crtCred:
        return 'Cartão de crédito';
      case TipoConta.ctaDebt:
        return 'Conta de débito';
    }
  }

  String _toStr() {
    switch (this) {
      case TipoConta.ctaCorr:
        return 'ctaCorr';
      case TipoConta.crtCred:
        return 'crtCred';
      case TipoConta.ctaDebt:
        return 'ctaDebt';
    }
  }

  String get toDescr => _toDescr();

  String get toStr => _toStr();
}

extension StringTipoContaExt on String {
  TipoConta? _toTipoConta() {
    switch (this) {
      case 'ctaCorr':
        return TipoConta.ctaCorr;
      case 'crtCred':
        return TipoConta.crtCred;
      case 'ctaDebt':
        return TipoConta.ctaDebt;
      default:
        return null;
    }
  }

  TipoConta? get toTipoConta => _toTipoConta();
}

List<TipoConta> listaTipoConta = [
  TipoConta.ctaCorr,
  TipoConta.crtCred,
  TipoConta.ctaDebt
];

class Conta {
  final TipoConta tipoConta;
  late String contaId;
  String nome;
  double saldoInicial;
  bool favorito;
  bool inativo;

  Conta({
    required this.tipoConta,
    String? contaId,
    required this.nome,
    this.saldoInicial = 0,
    this.favorito = false,
    this.inativo = false,
  }) {
    if (contaId == null || contaId.isEmpty) {
      Uuid uuid = const Uuid();
      this.contaId = uuid.v4();
    } else {
      this.contaId = contaId;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'tipoConta': tipoConta.toStr,
      'contaId': contaId,
      'nome': nome,
      'saldoInicial': saldoInicial,
      'favorito': favorito,
      'inativo': inativo,
    };
  }

  Conta.fromMap(Map<String, dynamic> map)
      : tipoConta = map['tipoConta'] != null
            ? (map['tipoConta'] as String).toTipoConta ?? TipoConta.ctaCorr
            : TipoConta.ctaCorr,
        contaId = map['contaId'],
        nome = map['nome'],
        saldoInicial = map['saldoInicial'] ?? 0,
        favorito = map['favorito'] ?? false,
        inativo = map['inativo'] ?? false;
}
