import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/popup_menu_user_cont.dart';
import '../controllers/user_auth_cont.dart';
import '../models/crud.dart';
import '../my_router.dart';
import 'wait_widget.dart';

class PopupMenuUserWidget extends ConsumerWidget {
  const PopupMenuUserWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color menuColor = Colors.black87;

    AsyncValue<PopupMenuUserCont> popupMenuUserCont =
        ref.watch(popupMenuUserContProvider);

    return popupMenuUserCont.when(
      loading: () => const WaitWidget(),
      error: (error, stackTrace) => Text('PopupMenuUserWidget-Erro:$error'),
      data: (data) {
        return PopupMenuButton(
          icon: CircleAvatar(
            child: Text(data.usuario.getInitials(qtd: 1)),
            backgroundColor: Colors.lightBlueAccent.shade200,
          ),
          onSelected: (value) async {
            switch (value) {
              case 'perfil':
                Navigator.pushNamed(
                  context,
                  MyRouter.usuarioCrud,
                  arguments: UsuarioCrudKey(
                    crud: Crud.update,
                    userId: UserAuthCont.usuarioId,
                  ),
                );
                break;
              case 'sair':
                await data.sair();
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Row(
                children: [
                  Flexible(
                    child: Center(
                      child: Icon(
                        Icons.account_box_outlined,
                        color: menuColor,
                      ),
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    child: Center(
                      child: Text(
                        'Perfil',
                        style: TextStyle(color: menuColor),
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              ),
              value: 'perfil',
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  Flexible(
                    child: Center(
                      child: Icon(
                        Icons.logout,
                        color: menuColor,
                      ),
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    child: Center(
                      child: Text(
                        'Sair',
                        style: TextStyle(color: menuColor),
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              ),
              value: 'sair',
            ),
          ],
          position: PopupMenuPosition.under,
        );
      },
    );
  }
}
