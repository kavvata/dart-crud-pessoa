import 'dart:io';

void main() {
  const Map<int, Function> acoes = {
    0: sair,
    1: cadastrar,
    2: buscar,
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
    // seguro, pois opcaoUsuario é checada antes de chegar
    // nessa linha
    acoes[opcaoUsuario]!.call();
  }
}

void mostraMenu() {
  String conteudo = "";

  conteudo += "1 - Cadastrar nova pessoa\n";
  conteudo += "2 - Buscar Pessoa\n";
  conteudo += "3 - Atualizar Pessoa\n";
  conteudo += "4 - Remover Pessoa\n";
  conteudo += "0 - Sair\n";

  stdout.write(conteudo + "> ");
}

void sair() {
  exit(0);
}

void cadastrar() {
  print("cadastrar");
}

void buscar() {
  print("buscar");
}

void atualizar() {
  print("atualizar");
}

void remover() {
  print("remover");
}
