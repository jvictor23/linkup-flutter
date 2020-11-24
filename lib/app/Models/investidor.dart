class Investidor {
  String id;
  String imagem;
  String nome;
  String telefone;
  String email;
  String senha;

  Investidor();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "nome": this.nome,
      "telefone": this.telefone,
      "email": this.email,
      "senha": this.senha
    };

    return map;
  }
}
