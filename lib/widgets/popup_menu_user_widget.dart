import 'package:contas/widgets/wait_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/popup_menu_user_cont.dart';

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
              onTap: () {},
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
              onTap: () async {
                await data.sair();
              },
            ),
          ],
          position: PopupMenuPosition.under,
        );
      },
    );
  }
}
