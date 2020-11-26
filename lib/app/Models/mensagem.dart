class Mensagem {
  String idUsuario;
  String idUsuarioDestinatario;
  String mensagem;
  String data;
  String tokenDestinatario;

  Mensagem();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": this.idUsuario,
      "mensagem": this.mensagem,
      "data": this.data
    };

    return map;
  }
}
