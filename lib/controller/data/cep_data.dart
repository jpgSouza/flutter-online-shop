import 'dart:convert';

class CepData {
  String cep;
  String street;
  String district;
  String locality;
  String uf;

  CepData({
    this.cep,
    this.street,
    this.district,
    this.locality,
    this.uf,
  });

  factory CepData.fromJson(String str) => CepData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CepData.fromMap(Map<String, dynamic> json) => CepData(
        cep: json["cep"],
        street: json["logradouro"],
        district: json["bairro"],
        locality: json["localidade"],
        uf: json["uf"],
      );

  Map<String, dynamic> toMap() => {
        "cep": cep,
        "logradouro": street,
        "bairro": district,
        "localidade": locality,
        "uf": uf,
      };
}
