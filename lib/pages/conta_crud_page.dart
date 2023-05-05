import 'package:contas/utils/show_meu_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/conta_crud_cont.dart';
import '../models/conta.dart';
import '../models/crud.dart';
import '../utils/resultado.dart';
import '../widgets/form_formatado.dart';
import '../widgets/meu_checkbox.dart';
import '../widgets/meu_text_form_field.dart';

// ignore: must_be_immutable
class ContaCrudPage extends ConsumerWidget {
  bool isLoading = true;
  final ContaCrudKey contaCrudKey;
  ContaCrudPage({super.key, required this.contaCrudKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contaCrudCont = ref.watch(contaCrudContProvider(contaCrudKey));
    if (isLoading) {
      isLoading = false;
      contaCrudCont.refresh();
    }
    return FormFormatado(
      formKey: contaCrudCont.formKey,
      appBarTitulo: 'Conta - ${contaCrudKey.crud.toDescr}',
      formBody: Column(
        children: [
          DropdownButtonFormField<TipoConta>(
            items: listaTipoConta
                .map<DropdownMenuItem<TipoConta>>((TipoConta tipoConta) {
              return DropdownMenuItem(
                child: Text(tipoConta.toDescr),
                value: tipoConta,
              );
            }).toList(),
            onChanged: (value) {
              if (value is TipoConta) {
                contaCrudCont.setTipoConta(value);
              }
            },
            validator: (value) => contaCrudCont.validarTipoConta(value),
          ),
          MeuTextFormField(
            controller: contaCrudCont.inputNome,
            labelText: 'Nome',
            validator: (value) => contaCrudCont.validarNome(value),
            isReadOnly: contaCrudCont.contaCrudKey.crud.isNotEdit,
          ),
          MeuTextFormField(
            controller: contaCrudCont.outputSaldoInicial,
            labelText: 'Saldo inicial',
            validator: (value) => contaCrudCont.validarNome(value),
            isReadOnly: contaCrudCont.contaCrudKey.crud.isNotEdit,
            textAlign: TextAlign.right,
          ),
          MeuCheckBox(
            campo: 'Favorita',
            value: contaCrudCont.inputFavorita,
            onChanged: (value) => contaCrudCont.setFavorita(value),
          ),
          MeuCheckBox(
            campo: 'Inativa',
            value: contaCrudCont.inputInativa,
            onChanged: (value) => contaCrudCont.setInativa(value),
          ),
        ],
      ),
      onSalvar: contaCrudKey.crud.isEdit
          ? (() async {
              Resultado resultado = await contaCrudCont.persistir();
              if (resultado.validado) {
                if (resultado.erro) {
                  showMeuSnackbar(
                    context,
                    resultado.mensagem,
                    tipoSnackBar: TipoSnackBar.erro,
                    showCloseIcon: true,
                  );
                } else {
                  Navigator.pop(context, true);
                }
              }
            })
          : null,
    );
  }
}
