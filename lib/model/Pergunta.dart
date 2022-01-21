class Pergunta {
  String id;
  String texto;
  String descricao;

  Pergunta(this.id, this.texto, this.descricao);

  factory Pergunta.fromJson(Map<String, dynamic> json) {
    return Pergunta(json['id'], json['texto'], json['descricao']);
  }
}
