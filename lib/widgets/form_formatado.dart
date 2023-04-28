import 'package:flutter/material.dart';

import 'menu_widget.dart';

class FormFormatado extends StatelessWidget {
  final String? appBarTitulo;
  final bool showMenu;
  final List<Widget>? appBarActions;
  final GlobalKey<FormState> formKey;
  final Widget formBody;
  final double maxWidth;
  final VoidCallback? onSalvar;
  final String salvarText;
  final IconData salvarIcon;

  const FormFormatado({
    Key? key,
    this.appBarTitulo,
    this.showMenu = false,
    this.appBarActions,
    required this.formKey,
    required this.formBody,
    this.maxWidth = double.infinity,
    this.onSalvar,
    this.salvarText = 'Salvar',
    this.salvarIcon = Icons.check,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (buildContext, constraints) {
      final isMobile = constraints.maxWidth < 600;

      return Scaffold(
        drawer: isMobile && showMenu ? MenuWidget(isMobile: isMobile) : null,
        appBar: (appBarTitulo == null && appBarTitulo == null)
            ? null
            : AppBar(
                title: Text(appBarTitulo ?? ''),
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
              ),
        body: isMobile || !showMenu
            ? body()
            : Row(
                children: [
                  MenuWidget(isMobile: isMobile),
                  body(),
                ],
              ),
      );
    });
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            padding: const EdgeInsets.all(8),
            child: Form(
                key: formKey,
                child: onSalvar == null
                    ? formBody
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          formBody,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: onSalvar,
                                  icon: Icon(salvarIcon),
                                  label: Text(salvarText),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
          ),
        ),
      ),
    );
  }
}
