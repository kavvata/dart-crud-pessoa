class Pessoa {
  int? _id;
  String _nome;
  String _email;
  String _telefone;
  int _idade;

  Pessoa(this._id, this._nome, this._email, this._telefone, this._idade);
  Pessoa.nova(this._nome, this._email, this._telefone, this._idade);

  int? getId() {
    return _id;
  }

  void setId(int id) {
    this._id = id;
  }

  String getNome() {
    return this._nome;
  }

  void setNome(nome) {
    this._nome = nome;
  }

  String getEmail() {
    return this._email;
  }

  void setEmail(email) {
    this._email = email;
  }

  String getTelefone() {
    return this._telefone;
  }

  void setTelefone(telefone) {
    this._telefone = telefone;
  }

  int getIdade() {
    return this._idade;
  }

  void setIdade(idade) {
    this._idade = idade;
  }
}
