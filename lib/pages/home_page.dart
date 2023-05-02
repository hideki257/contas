import 'package:flutter/material.dart';

import '../widgets/pagina_formatada.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return PaginaFormatada(
      appBarTitulo: 'Controle de contas',
      page: Container(),
      showMenu: true,
    );
  }
}
