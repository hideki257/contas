class Usuario {
  final String userId;
  final String email;
  String? nome;
  DateTime? dataNascimento;

  String get getNome => _getNome();

  String get getInitialsDef => getInitials(qtd: 2);

  Usuario({
    required this.userId,
    required this.email,
    this.nome,
    this.dataNascimento,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'nome': nome,
      'dataNascimento': dataNascimento?.millisecondsSinceEpoch,
    };
  }

  Map<String, dynamic> toMapUpdate() {
    return {
      'nome': nome,
      'dataNascimento': dataNascimento?.millisecondsSinceEpoch,
    };
  }

  Usuario.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        email = map['email'],
        nome = map['nome'],
        dataNascimento = map['dataNascimento'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['dataNascimento'])
            : null;

  String _getNome() {
    return nome != null && nome!.trim().isNotEmpty ? nome! : email;
  }

  String getInitials({int qtd = 2}) {
    String result = '';
    String _nome = _getNome().trim().toUpperCase();
    final splited = _nome.split(' ');
    for (int i = 0; i < splited.length; i++) {
      if (i >= qtd) break;
      result += splited[i][0];
    }
    return result;
  }
}
