class Mensagem {
  String idUsuario;
  String idUsuarioDestinatario;
  String mensagem;

  Mensagem();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": this.idUsuario,
      "mensagem": this.mensagem,
    };

    return map;
  }
}
