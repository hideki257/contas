import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/user_auth_data.dart';
import '../data/usuario_data.dart';
import '../models/usuario.dart';

final popupMenuUserContProvider =
    FutureProvider<PopupMenuUserCont>((ref) async {
  PopupMenuUserCont popupMenuUserCont = PopupMenuUserCont(ref: ref);
  await popupMenuUserCont.refresh();
  return popupMenuUserCont;
});

class PopupMenuUserCont {
  final Ref ref;
  late Usuario usuario;
  PopupMenuUserCont({required this.ref});

  refresh() async {
    UsuarioData usuarioData = ref.read(usuarioDataProvider);
    usuario =
        await usuarioData.getUsuarioById(userId: UserAuthData.usuarioId ?? '');
  }

  sair() async {
    UserAuthData userAuthData = ref.read(userAuthDataProvider);
    await userAuthData.sair();
  }
}
