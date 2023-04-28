enum Crud {
  create,
  read,
  update,
  delete,
}

extension CrudExt on Crud {
  String _toDescr() {
    switch (this) {
      case Crud.create:
        return 'Criar';
      case Crud.read:
        return 'Ver';
      case Crud.update:
        return 'Alterar';
      case Crud.delete:
        return 'Apagar';
    }
  }

  String _toMap() {
    switch (this) {
      case Crud.create:
        return 'create';
      case Crud.read:
        return 'read';
      case Crud.update:
        return 'update';
      case Crud.delete:
        return 'delete';
    }
  }

  String get toDescr => _toDescr();
  String get toMap => _toMap();

  bool get isNew => this == Crud.create;
  bool get isNowNew => !isNew;

  bool get isAction =>
      this == Crud.create || this == Crud.update || this == Crud.delete;
  bool get isNotAction => !isAction;

  bool get isEdit => this == Crud.create || this == Crud.update;
  bool get isNotEdit => !isEdit;
}

class CrudKey {
  final Crud crud;
  List<Map<String, dynamic>> keys;

  CrudKey({required this.crud, required this.keys});
}
