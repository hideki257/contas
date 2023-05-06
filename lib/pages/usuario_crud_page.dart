import 'package:contas/controllers/usuario_crud_cont.dart';
import 'package:contas/utils/show_meu_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/crud.dart';
import '../utils/resultado.dart';
import '../widgets/form_formatado.dart';
import '../widgets/meu_text_form_field.dart';

class UsuarioCrudPage extends ConsumerWidget {
  final UsuarioCrudKey usuarioCrudKey;
  const UsuarioCrudPage({super.key, required this.usuarioCrudKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UsuarioCrudCont usuarioCrudCont =
        ref.watch(usuarioCrudContProvider(usuarioCrudKey));

    return FormFormatado(
      formKey: usuarioCrudCont.formKey,
      appBarTitulo: 'Usuario - ${usuarioCrudKey.crud.toDescr}',
      formBody: Column(
        children: [
          MeuTextFormField(
            controller: usuarioCrudCont.inputEmail,
            isReadOnly: true,
            labelText: 'Email',
          ),
          MeuTextFormField(
            controller: usuarioCrudCont.inputNome,
            isReadOnly: usuarioCrudKey.crud.isNotEdit,
            labelText: 'Nome',
            validator: (value) => usuarioCrudCont.validarNome(value),
          ),
          MeuTextFormField(
            controller: usuarioCrudCont.outputDataNasc,
            isData: true,
            labelText: 'Data de nascimento',
            onTap: () async {
              DateTime? dataNasc = await showDatePicker(
                context: context,
                initialDate: usuarioCrudCont.inputDataNasc ?? DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 120),
                lastDate: DateTime.now(),
              );
              if (dataNasc != null) {
                usuarioCrudCont.setDataNasc(dataNasc);
              }
            },
            showClearButton: usuarioCrudCont.inputDataNasc != null,
            onClearButtonTap: () {
              usuarioCrudCont.setDataNasc(null);
            },
          ),
        ],
      ),
      onSalvar: () async {
        Resultado resultado = await usuarioCrudCont.alterarUsuario();
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
      },
    );
  }
}
