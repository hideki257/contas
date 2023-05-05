import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/conta_data.dart';
import '../models/conta.dart';

final contaListContProvider = FutureProvider<ContaListCont>((ref) async {
  ContaListCont contaListCont = ContaListCont(ref: ref);
  await contaListCont.refresh();
  return contaListCont;
});

class ContaListCont {
  final Ref ref;
  ContaListCont({required this.ref});
  List<Conta> contas = [];

  refresh() async {
    contas.clear();
    ContaData contaData = ref.watch(contaDataProvider);
    contas = await contaData.listarTodas();
    contas.sort((a, b) => a.nome.toUpperCase().compareTo(b.nome.toUpperCase()));
  }
}
