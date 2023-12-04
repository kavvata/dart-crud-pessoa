import 'dart:io';

void main() {
  const Map<int, Function> acoes = {
    0: sair,
    1: listar,
    2: cadastrar,
    3: buscar,
    4: atualizar,
    5: remover
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
  conteudo += "3 - Buscar pessoa\n";
  conteudo += "4 - Atualizar pessoa\n";
  conteudo += "5 - Remover pessoa\n";
  conteudo += "0 - Sair\n";

  stdout.write(conteudo + "> ");
}

void sair() {
  exit(0);
}

void listar() {
  // TODO
  print("listar");
}

void cadastrar() {
  // TODO
  print("cadastrar");
}

void buscar() {
  // TODO
  print("buscar");
}

void atualizar() {
  // TODO
  print("atualizar");
}

void remover() {
  // TODO
  print("remover");
}
