import 'package:http/http.dart' as http;
import 'package:popquiz/model/Pergunta.dart';
import 'dart:convert' as conversor;
import 'package:popquiz/model/Questionario.dart';

const URL = "https://61e970687bc0550017bc62b9.mockapi.io/api/v1/questionario";

class ApiMock {

  Future<List<Questionario>?> recuperarListaDeQuestionarios() async {
    var url = Uri.parse(URL);
    var respostaResquisicaoHttp = await http.get(url);

    if (respostaResquisicaoHttp.statusCode == 200) {
      var dadosEmJson = conversor.json.decode(respostaResquisicaoHttp.body);
      List<Questionario> listaDeQuestionario = [];

      for (var item in dadosEmJson ){
        Questionario questionario = Questionario(item['id'],item['titulo']);
        listaDeQuestionario.add(questionario);
      }

      return listaDeQuestionario;
    } else {
      print("Aconteceu algo de errado!");
      print("Código do erro: ${respostaResquisicaoHttp.statusCode}");
    }

    return null;
  }

  Future<List<Pergunta>?> recuperarPergunstasDoQuestionario(String idDoQuestionario) async {
    var url = Uri.parse(URL+'/$idDoQuestionario');
    var respostaResquisicaoHttp = await http.get(url);

    if (respostaResquisicaoHttp.statusCode == 200) {
      Map<String, dynamic> dadosEmJson = conversor.json.decode(respostaResquisicaoHttp.body);
      List<Pergunta> listaDePerguntas = [];
      listaDePerguntas =
          dadosEmJson["questoes"].map<Pergunta>((map) {
        return Pergunta.fromJson(map);
      }).toList();
      
      return listaDePerguntas;
    } else {
      print("Aconteceu algo de errado!");
      print("Código do erro: ${respostaResquisicaoHttp.statusCode}");
    }

    return null;
  }

  Future<void> salvarNovoQuestionario(Questionario questionario) async{
    var url = Uri.parse(URL);
    var cabecalho = {'Content-type': 'application/json; charset=UTF-8'};
    var corpo = conversor.json.encode(
      {
        "id": questionario.id,
        "titulo": questionario.titulo,
        "questoes": []
      }
    );
    
    http.Response resposta = await http.post(
        url,
        headers: cabecalho,
        body: corpo);

    print("Informações enviadas: ${resposta.body}");
    print("Status do envio: ${resposta.statusCode}");
  }

  Future<void> salvarNovaPergunta(String idQuestionario, Pergunta pergunta) async{
    String _extencaoDaURL = "/$idQuestionario/questoes";
    var url = Uri.parse(URL+_extencaoDaURL);
    var cabecalho = {'Content-type': 'application/json; charset=UTF-8'};
    var corpo = conversor.json.encode(
      {
        "id": pergunta.id,
        "texto": pergunta.texto,
        "descricao": pergunta.descricao,
        "questionarioId": idQuestionario,
      }
    );
    
    http.Response resposta = await http.post(
        url,
        headers: cabecalho,
        body: corpo);

    print("Informações enviadas: ${resposta.body}");
    print("Status do envio: ${resposta.statusCode}");
  }
}
