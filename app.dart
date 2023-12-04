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

    // le stdin.
    // Se for nulo, retorna string vazia.
    //Se nao, retorna entrada.
    opcaoUsuario = int.parse(stdin.readLineSync() ?? "");

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
  // TODO
  print("atualizar");
}

void remover() {
  // TODO
  print("remover");
}
