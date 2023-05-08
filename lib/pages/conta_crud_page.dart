import 'package:contas/utils/show_meu_snackbar.dart';
import 'package:contas/widgets/meu_dropdown.dart';
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
      maxWidth: 1000,
      formBody: Column(
        children: [
          MeuDropdown<TipoConta>(
            labelText: 'Tipo de conta',
            items: listaTipoConta
                .map<DropdownMenuItem<TipoConta>>((TipoConta tipoConta) {
              return DropdownMenuItem(
                value: tipoConta,
                child: Text(tipoConta.toDescr),
              );
            }).toList(),
            onChanged: (value) {
              if (value is TipoConta) {
                contaCrudCont.setTipoConta(value);
              }
            },
            validator: (value) => contaCrudCont.validarTipoConta(value),
            value: contaCrudCont.inputTipoConta,
            isReadOnly: contaCrudKey.crud.isNotNew,
          ),
          MeuTextFormField(
            controller: contaCrudCont.inputNome,
            labelText: 'Nome',
            validator: (value) => contaCrudCont.validarNome(value),
            isReadOnly: contaCrudCont.contaCrudKey.crud.isNotEdit,
          ),
          MeuTextFormField(
            controller: contaCrudCont.inputSaldoInicial,
            labelText: 'Saldo inicial',
            validator: (value) => contaCrudCont.validarSaldoInicial(value),
            isReadOnly: contaCrudCont.contaCrudKey.crud.isNotEdit,
            textAlign: TextAlign.right,
          ),
          MeuTextFormField(
            controller: contaCrudCont.inputLimiteCredito,
            labelText: 'Limite de crédito',
            validator: (value) => contaCrudCont.validarLimiteCredito(value),
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
                // ignore: use_build_context_synchronously
                if (!context.mounted) return;
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
