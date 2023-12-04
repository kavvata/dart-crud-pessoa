class Pessoa {
  int? _id;
  String _nome;
  String _email;
  String _telefone;
  int _idade;

  Pessoa(this._id, this._nome, this._email, this._telefone, this._idade);
  Pessoa.nova(this._nome, this._email, this._telefone, this._idade);

  // sintaxe arrow function de getters e setters.
  int? get id => _id;
  set id(int? id) => _id = id;

  String get nome => _nome;
  set nome(String nome) => _nome = nome;

  String get email => _email;
  set email(String email) => _email = email;

  String get telefone => _telefone;
  set telefone(String telefone) => _telefone = telefone;

  int get idade => _idade;

  set idade(int idade) {
    if (idade < 0) {
      throw new Exception("idade '$idade' inválida!");
    }
    _idade = idade;
  }

  String toString() {
    String relatorio = "";

    relatorio += "$_id - ";
    relatorio += "Nome: $_nome / ";
    relatorio += "Email: $_email / ";
    relatorio += "Telefone: $_telefone / ";
    relatorio += "idade: $_idade";

    return relatorio;
  }
}
