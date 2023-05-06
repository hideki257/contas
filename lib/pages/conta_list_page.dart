import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/conta_list_cont.dart';
import '../models/conta.dart';
import '../models/crud.dart';
import '../my_router.dart';
import '../widgets/page_message_widget.dart';
import '../widgets/page_wait_widget.dart';
import '../widgets/pagina_formatada.dart';
import '../utils/formatacao_utils.dart';

class ContaListPage extends ConsumerWidget {
  ContaListPage({super.key});
  bool isLoading = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String appTitle = 'Contas - Listar';
    final contaListCont = ref.watch(contaListContProvider);
    if (isLoading) {
      isLoading = false;
      contaListCont.refresh();
    }

    return PaginaFormatada(
      appBarTitulo: appTitle,
      appBarActions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, MyRouter.contaCrud,
                    arguments: ContaCrudKey(crud: Crud.create))
                .then((value) {
              if (value is bool && value) {
                contaListCont.refresh();
              }
            });
          },
        ),
      ],
      page: contaListCont.contas.isEmpty
          ? const Center(child: Text('Nenhuma conta encontrada!'))
          : ListView.separated(
              itemCount: contaListCont.contas.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                  ),
                  child: ListTile(
                    shape: const OutlineInputBorder(),
                    title: Text(contaListCont.contas[index].nome),
                    subtitle: Text(contaListCont.contas[index].saldoInicial
                        .toStrForm2Dig()),
                    leading: Icon(contaListCont.contas[index].tipoConta.toIcon),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          contaListCont.contas[index].favorito
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: contaListCont.contas[index].favorito
                              ? Colors.redAccent.shade700
                              : null,
                        ),
                        Icon(
                          contaListCont.contas[index].inativo
                              ? Icons.do_disturb
                              : Icons.check,
                          color: contaListCont.contas[index].inativo
                              ? Colors.grey.shade700
                              : Colors.green.shade700,
                        ),
                      ],
                    ),
                    onTap: () async {
                      Navigator.pushNamed(
                        context,
                        MyRouter.contaCrud,
                        arguments: ContaCrudKey(
                          crud: Crud.update,
                          contaId: contaListCont.contas[index].contaId,
                        ),
                      ).then((value) async {
                        if (value is bool && value) {
                          await contaListCont.refresh();
                        }
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
