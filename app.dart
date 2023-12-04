import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

import 'daos/pessoaDAO.dart';
import 'entities/Pessoa.dart';
import 'repositories/repositorioPessoa.dart';

final dao = PessoaDAO(sqlite3.open("./db.sqlite"));
final repo = RepositorioPessoa(dao);

void main() {
  const Map<int, Function> acoes = {
    0: sair,
    1: listar,
    2: cadastrar,
    3: atualizar,
    4: remover
  };

  int opcaoUsuario = -1;

  while (opcaoUsuario != 0) {
    mostraMenu();

    // lê stdin.
    // Se for nulo, retorna string vazia.
    //Se nao, retorna entrada.
    String entrada = stdin.readLineSync() ?? "";

    // int.parse() gera excessão se string for vazia.
    // usando operador ternario para mudar para -1 se for o caso.
    opcaoUsuario = int.parse(entrada.isEmpty ? "-1" : entrada);

    if (!acoes.containsKey(opcaoUsuario)) {
      print("Opção inválida");
      continue;
    }

    // ! -> assume acoes[i] como nunca nulo
    // seguro, opcaoUsuario é checado antes de chegar nessa linha
    acoes[opcaoUsuario]!.call();
  }
}

void mostraMenu() {
  String conteudo = "";

  conteudo += "1 - Listar pessoas\n";
  conteudo += "2 - Cadastrar nova pessoa\n";
  conteudo += "3 - Atualizar pessoa\n";
  conteudo += "4 - Remover pessoa\n";
  conteudo += "0 - Sair\n";

  stdout.write(conteudo + "> ");
}

String getString() {
  String input = "";

  while (input.isEmpty) {
    input = stdin.readLineSync() ?? "";
  }

  return input;
}

void sair() {
  exit(0);
}

void listar() {
  Set<Pessoa> lista = repo.listarPessoas();

  print("=== LISTA DE PESSOAS ===");
  lista.forEach((pessoa) {
    print(pessoa.toString());
  });
  print("");
}

void cadastrar() {
  print("=== CADASTRO ===");

  stdout.write("Nome: ");
  String nome = getString();

  stdout.write("Email: ");
  String email = getString();

  stdout.write("Telefone: ");
  String telefone = getString();

  stdout.write("Idade: ");
  int idade = int.parse(getString());

  Pessoa nova = repo.cadastrarPessoa(nome, email, telefone, idade);

  print("Pessoa cadastrada! id: " + nova.getId().toString());
}

void atualizar() {
  print("=== ATUALIZAR ===");

  stdout.write("Digite o id da Pessoa a ser editada\n> ");
  int id = int.parse(getString());

  Pessoa? p = repo.buscarPessoaId(id);
  if (p == null) {
    print("Pessoa $id nao encontrada");
    return;
  }

  print("para não alterar dado, deixar vazio");

  stdout.write("Novo nome: ");
  String nome = stdin.readLineSync() ?? "";

  stdout.write("Novo email: ");
  String email = stdin.readLineSync() ?? "";

  stdout.write("Novo telefone: ");
  String telefone = stdin.readLineSync() ?? "";

  stdout.write("Nova idade: ");
  String idadeStr = stdin.readLineSync() ?? "";

  p.setNome(nome.isEmpty ? p.getNome() : nome);
  p.setEmail(email.isEmpty ? p.getEmail() : email);
  p.setTelefone(telefone.isEmpty ? p.getTelefone() : telefone);
  p.setIdade(idadeStr.isEmpty ? p.getIdade() : int.parse(idadeStr));

  final ret = repo.atualizarPessoa(
      id, p.getNome(), p.getEmail(), p.getTelefone(), p.getIdade());

  if (ret == null) {
    print("Erro ao atualizar.");
  }

  print("Pessoa atualizada!");
}

void remover() {
  stdout.write("Digite o id da Pessoa a ser removida\n> ");
  int id = int.parse(getString());

  if (repo.buscarPessoaId(id) == null) {
    print("Pessoa $id nao encontrada");
    return;
  }

  final sucesso = repo.removerPessoa(id);

  if (!sucesso) {
    print("Erro ao remover.");
    return;
  }

  print("Pessoa removida com sucesso.");
}
