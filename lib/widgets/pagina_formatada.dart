import 'package:flutter/material.dart';

import 'menu_widget.dart';
import 'popup_menu_user_widget.dart';

class PaginaFormatada extends StatelessWidget {
  final Key? scaffoldKey;
  final String? appBarTitulo;
  final List<Widget>? appBarActions;
  final bool showMenu;
  final Widget page;
  const PaginaFormatada({
    Key? key,
    this.scaffoldKey,
    this.appBarTitulo,
    this.appBarActions,
    required this.page,
    this.showMenu = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget>? appBarActions = this.appBarActions;

    if (appBarTitulo != null) {
      if (appBarActions != null) {
        appBarActions.add(const PopupMenuUserWidget());
      } else {
        appBarActions = [const PopupMenuUserWidget()];
      }
    }

    return LayoutBuilder(builder: (contextBuilder, constraints) {
      final isMobile = constraints.maxWidth < 600;
      return Scaffold(
        key: scaffoldKey,
        drawer: isMobile && showMenu ? MenuWidget(isMobile: isMobile) : null,
        appBar: (appBarTitulo != null && appBarTitulo!.trim().isNotEmpty)
            ? AppBar(
                title: Text(appBarTitulo!),
                actions: appBarActions,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigoAccent.shade400,
                        Colors.indigoAccent.shade100,
                      ],
                    ),
                  ),
                ),
              )
            : null,
        body: isMobile || !showMenu
            ? page
            : Row(
                children: [
                  MenuWidget(isMobile: isMobile),
                  Flexible(child: page),
                ],
              ),
      );
    });
  }
}
