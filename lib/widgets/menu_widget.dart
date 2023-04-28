import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/menu_cont.dart';
import '../my_router.dart';
import 'wait_widget.dart';

class MenuWidget extends ConsumerWidget {
  final bool isMobile;
  const MenuWidget({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<MenuCont> menuCont = ref.watch(menuContProvider);

    return menuCont.when(
      loading: () => const WaitWidget(),
      error: (erro, __) => Text('Erro:$erro'),
      data: (data) {
        return Drawer(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.indigoAccent.shade400,
                    Colors.indigoAccent.shade100,
                  ]),
                ),
                child: ListTile(
                  leading:
                      isMobile ? const Icon(Icons.keyboard_arrow_left) : null,
                  title: Text(
                    'Olá, ${data.usuario?.getNome}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  onTap: () {
                    if (isMobile) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text(
                  'Home Page',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, MyRouter.homePage);
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(
                  'Sair',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  data.sair();
                  if (isMobile) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
