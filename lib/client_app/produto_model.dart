import '../config.dart';

class Produto {
  final int id;
  final String nome;
  final double preco;
  final int estoque;
  final String? imagemUrl;

  Produto({
    required this.id,
    required this.nome,
    required this.preco,
    required this.estoque,
    this.imagemUrl,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    String? urlFinal;
    
    if (json['imagem'] != null) {
      String imgString = json['imagem'].toString();
      // O Pulo do Gato: 
      // Se a imagem já vier do Cloudinary (começa com http), o app usa ela direto.
      // Se for uma foto velha perdida, ele tenta montar o link base.
      if (imgString.startsWith('http')) {
        urlFinal = imgString;
      } else {
        urlFinal = "${Config.baseUrl}$imgString";
      }
    }

    return Produto(
      id: json['id'],
      nome: json['nome_venda'], 
      preco: double.parse(json['preco_venda'].toString()),
      estoque: json['estoque_atual'] ?? 0,
      imagemUrl: urlFinal,
    );
  }

  String get imagemAsset {
    String nomeLimpo = nome.toLowerCase();
    nomeLimpo = _removerAcentos(nomeLimpo);
    nomeLimpo = nomeLimpo.replaceAll(' ', '_');
    return "assets/produtos/$nomeLimpo.png";
  }

  String _removerAcentos(String texto) {
    var comAcento = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var semAcento = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    for (int i = 0; i < comAcento.length; i++) {
      texto = texto.replaceAll(comAcento[i], semAcento[i]);
    }
    return texto;
  }
}