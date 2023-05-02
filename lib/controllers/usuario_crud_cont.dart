import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/crud.dart';

final usuarioCrudContProvider =
    FutureProvider.family<UsuarioCrudCont, UsuarioCrudKey>(
  (ref, usuarioCrudKey) async {
    UsuarioCrudCont usuarioCrudCont =
        UsuarioCrudCont(ref: ref, usuarioCrudKey: usuarioCrudKey);
    await usuarioCrudCont.refresh();
    return usuarioCrudCont;
  },
);

class UsuarioCrudCont {
  final Ref ref;
  final UsuarioCrudKey usuarioCrudKey;
  UsuarioCrudCont({required this.ref, required this.usuarioCrudKey});

  final formKey = GlobalKey<FormState>();
  final outputEmail = TextEditingController();
  final inputNome = TextEditingController();

  refresh() async {
    if (usuarioCrudKey.crud.isNowNew) {}
  }
}
