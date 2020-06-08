import 'package:flutter_online_shop/data/cep_data.dart';
import 'package:http/http.dart' as http;

class CepService {
  static Future<CepData> fetchCep({String cep}) async {
    final response = await http.get('https://viacep.com.br/ws/$cep/json/');
    if (response.statusCode == 200) {
      return CepData.fromJson(response.body);
    } else {
      throw Exception('Requisição inváilida!');
    }
  }
}
