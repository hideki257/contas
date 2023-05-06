import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/conta_data.dart';
import '../models/conta.dart';

final contaListContProvider =
    ChangeNotifierProvider<ContaListCont>((ref) => ContaListCont(ref: ref));

class ContaListCont extends ChangeNotifier {
  final Ref ref;
  ContaListCont({required this.ref});
  List<Conta> contas = [];

  refresh() async {
    contas.clear();
    ContaData contaData = ref.watch(contaDataProvider);
    contas = await contaData.listarTodas();
    contas.sort((a, b) => a.nome.toUpperCase().compareTo(b.nome.toUpperCase()));
    notifyListeners();
  }
}
