class Usuario {
  String id;
  String imagem;
  String nome;
  String telefone;
  String email;
  String senha;
  String tipo;
  String tokenNotification;

  Usuario();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "nome": this.nome,
      "telefone": this.telefone,
      "email": this.email,
      "senha": this.senha,
      "tipo": this.tipo
    };

    return map;
  }
}
