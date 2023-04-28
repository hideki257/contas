import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/usuario_data.dart';
import '../models/usuario.dart';

final menuContProvider =
    FutureProvider<MenuCont>((ref) async => MenuCont(ref: ref));

class MenuCont {
  final Ref ref;
  Usuario? usuario;

  MenuCont({required this.ref}) {
    refresh();
  }

  refresh() async {
    UsuarioData usuarioData = ref.read(usuarioDataProvider);
    usuario = await usuarioData.getUsuarioById(userId: '');
  }

  sair() {}
}
