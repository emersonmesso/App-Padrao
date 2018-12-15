class Torrent{
  String nome;
  String capa;
  String sinopse;
  String ano;
  String tamanho;
  String downloads;
  String qualidade;
  String audio;
  String fundo;
  String video;

  Torrent(this.nome, this.capa, this.sinopse, this.ano, this.tamanho,
      this.downloads, this.qualidade, this.audio, this.fundo, this.video);

}

class Dados{
  List filmes;
  List series;

  Dados(this.filmes, this.series);

  factory Dados.fromJson(Map<String, dynamic> json){
    return Dados(
      json['filmes'],
      json['serie']
    );
  }

}