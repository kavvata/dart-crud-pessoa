import '../daos/pessoaDAO.dart';
import '../entities/Pessoa.dart';

class RepositorioPessoa {
  PessoaDAO _dao;

  RepositorioPessoa(this._dao);

  Set<Pessoa> listarPessoas() {
    return _dao.listarPessoas();
  }

  Pessoa cadastrarPessoa(
      String nome, String email, String telefone, int idade) {
    return _dao.cadastrarPessoa(Pessoa.nova(nome, email, telefone, idade));
  }

  Pessoa? atualizarPessoa(
      int id, String nome, String email, String telefone, int idade) {
    return _dao.atualizarPessoa(id, Pessoa(id, nome, email, telefone, idade));
  }

  Pessoa? buscarPessoaId(int id) {
    return _dao.buscarPessoaId(id);
  }

  bool removerPessoa(int id) {
    return _dao.removerPessoa(id);
  }
}
