import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/conta_list_cont.dart';
import '../models/conta.dart';
import '../models/crud.dart';
import '../my_router.dart';
import '../widgets/pagina_formatada.dart';
import '../widgets/wait_widget.dart';
import '../utils/formatacao_utils.dart';

class ContaListPage extends ConsumerWidget {
  const ContaListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<ContaListCont> contaListCont = ref.watch(contaListContProvider);

    return PaginaFormatada(
      appBarTitulo: 'Contas - Listar',
      page: contaListCont.when(
        loading: () => const WaitWidget(),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (data) => data.contas.isEmpty
            ? const Center(child: Text('Nenhuma conta encontrada!'))
            : ListView.separated(
                itemCount: data.contas.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data.contas[index].nome),
                    subtitle:
                        Text(data.contas[index].saldoInicial.toStrForm2Dig()),
                    leading: Text(data.contas[index].tipoConta.toDescr),
                    /*
                    trailing: Row(
                      children: [
                        Icon(
                          data.contas[index].favorito
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: data.contas[index].favorito
                              ? Colors.redAccent.shade700
                              : null,
                        ),
                        Icon(
                          data.contas[index].inativo
                              ? Icons.do_disturb
                              : Icons.check,
                          color: data.contas[index].inativo
                              ? Colors.grey.shade700
                              : Colors.green.shade700,
                        ),
                      ],
                    ),
                    */
                  );
                },
              ),
      ),
    );
  }
}
