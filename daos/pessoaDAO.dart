import 'package:sqlite3/sqlite3.dart';

import '../entities/Pessoa.dart';

class PessoaDAO {
  final Database _db;

  PessoaDAO(this._db);

  Set<Pessoa> listarPessoas() {
    ResultSet rs = _db.select("SELECT * FROM pessoas");

    Set<Pessoa> lista = Set();

    for (final Row linha in rs) {
      Pessoa p = Pessoa(linha['id'], linha['nome'], linha['email'],
          linha['telefone'], int.parse(linha['idade']));

      lista.add(p);
    }

    return lista;
  }

  Pessoa cadastrarPessoa(Pessoa pessoa) {
    final pstm = _db.prepare(''' 
      INSERT INTO pessoa(nome, email, telefone, idade)
      VALUES (?,?,?,?)
    ''');

    pstm.execute([
      pessoa.getNome(),
      pessoa.getEmail(),
      pessoa.getTelefone(),
      pessoa.getIdade()
    ]);

    int id = _db.lastInsertRowId;
    pessoa.setId(id);

    return pessoa;
  }

  Pessoa atualizarPessoa(int id, Pessoa pessoa) {}

  Pessoa buscarPessoaNome(String nome) {}

  bool removerPessoa(int id) {}
}
