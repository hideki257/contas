import 'package:flutter/material.dart';

import '../widgets/pagina_formatada.dart';
import '../widgets/popup_menu_user_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return PaginaFormatada(
      appBarTitulo: 'Controle de contas',
      page: Container(),
      showMenu: true,
      appBarActions: const [PopupMenuUserWidget()],
    );
  }
}
