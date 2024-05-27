// To parse this JSON data, do
//
//     final demo = demoFromMap(jsonString);

import 'dart:convert';

MakeSuccess demoFromMap(String str) => MakeSuccess.fromMap(json.decode(str));

String demoToMap(MakeSuccess data) => json.encode(data.toMap());

class MakeSuccess {
  List<AppCodesArray>? appCodesArray;
  String? respCode;
  String? errMessage;

  MakeSuccess({
    this.appCodesArray,
    this.respCode,
    this.errMessage,
  });

  factory MakeSuccess.fromMap(Map<String, dynamic> json) => MakeSuccess(
        appCodesArray: json["appCodesArray"] == null
            ? []
            : List<AppCodesArray>.from(
                json["appCodesArray"]!.map((x) => AppCodesArray.fromMap(x))),
        respCode: json["respCode"],
        errMessage: json["errMessage"],
      );

  Map<String, dynamic> toMap() => {
        "appCodesArray": appCodesArray == null
            ? []
            : List<dynamic>.from(appCodesArray!.map((x) => x.toMap())),
        "respCode": respCode,
        "errMessage": errMessage,
      };
}

class AppCodesArray {
  String? code;
  String? desc;
  String? value;
  String? descAr;
  String? longDesc;
  String? longDescBl;
  dynamic colourCode;
  int? makeCount;
  String? brandType;
  String? brand;

  AppCodesArray({
    this.code,
    this.desc,
    this.value,
    this.descAr,
    this.longDesc,
    this.longDescBl,
    this.colourCode,
    this.makeCount,
    this.brandType,
    this.brand,
  });

  factory AppCodesArray.fromMap(Map<String, dynamic> json) => AppCodesArray(
        code: json["code"],
        desc: json["desc"],
        value: json["value"],
        descAr: json["descAr"],
        longDesc: json["longDesc"],
        longDescBl: json["longDescBl"],
        colourCode: json["colourCode"],
        makeCount: json["makeCount"],
        brandType: json["brandType"],
        brand: json["brand"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "desc": desc,
        "value": value,
        "descAr": descAr,
        "longDesc": longDesc,
        "longDescBl": longDescBl,
        "colourCode": colourCode,
        "makeCount": makeCount,
        "brandType": brandType,
        "brand": brand,
      };
}
