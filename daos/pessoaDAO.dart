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
          linha['telefone'], linha['idade']);

      lista.add(p);
    }

    return lista;
  }

  Pessoa cadastrarPessoa(Pessoa pessoa) {
    final pstm = _db.prepare(''' 
      INSERT INTO pessoas(nome, email, telefone, idade)
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

  Pessoa? atualizarPessoa(int id, Pessoa pessoa) {
    final pstm = _db.prepare('''
      UPDATE pessoas SET nome=?, email=?, telefone=?, idade=? WHERE id=?
    ''');

    pstm.execute([
      pessoa.getNome(),
      pessoa.getEmail(),
      pessoa.getTelefone(),
      pessoa.getIdade(),
      id
    ]);

    int countAlteradas = _db.getUpdatedRows();

    if (countAlteradas != 1) {
      print("ERRO: $countAlteradas tabelas alteradas.");
      return null;
    }

    return pessoa;
  }

  Pessoa? buscarPessoaId(int id) {
    final pstm = _db.prepare("SELECT * FROM pessoas WHERE id=?");
    ResultSet rs = pstm.select([id]);

    if (rs.isEmpty) {
      // Pessoa nao encontrada
      return null;
    }

    Row linha = rs.first;

    return Pessoa(linha['id'], linha['nome'], linha['email'], linha['telefone'],
        linha['idade']);
  }

  bool removerPessoa(int id) {
    final pstm = _db.prepare("DELETE FROM pessoas WHERE id=?");
    pstm.execute([id]);

    int countAlteradas = _db.getUpdatedRows();

    if (countAlteradas != 1) {
      print("ERRO: $countAlteradas tabelas alteradas.");
      return false;
    }

    return true;
  }
}
