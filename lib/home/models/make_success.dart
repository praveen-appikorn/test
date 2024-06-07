import 'dart:convert';

MakeSuccess demoFromJson(String str) => MakeSuccess.fromJson(json.decode(str));

String demoToJson(MakeSuccess data) => json.encode(data.toJson());

class MakeSuccess {
  List<AppCodesArray>? appCodesArray;
  String? respCode;
  String? errMessage;

  MakeSuccess({
    this.appCodesArray,
    this.respCode,
    this.errMessage,
  });

  MakeSuccess copyWith(MakeSuccess data) => MakeSuccess(
        appCodesArray: data.appCodesArray ?? appCodesArray,
        respCode: data.respCode ?? respCode,
        errMessage: data.errMessage ?? errMessage,
      );

  factory MakeSuccess.fromJson(Map<String, dynamic> json) => MakeSuccess(
        appCodesArray: json["appCodesArray"] == null
            ? []
            : List<AppCodesArray>.from(
                json["appCodesArray"]!.map((x) => AppCodesArray.fromJson(x))),
        respCode: json["respCode"],
        errMessage: json["errMessage"],
      );

  Map<String, dynamic> toJson() => {
        "appCodesArray": appCodesArray == null
            ? []
            : List<dynamic>.from(appCodesArray!.map((x) => x.toJson())),
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

  AppCodesArray copyWith(AppCodesArray data) => AppCodesArray(
        code: data.code ?? code,
        desc: data.desc ?? desc,
        value: data.value ?? value,
        descAr: data.descAr ?? descAr,
        longDesc: data.longDesc ?? longDesc,
        longDescBl: data.longDescBl ?? longDescBl,
        colourCode: data.colourCode ?? colourCode,
        makeCount: data.makeCount ?? makeCount,
        brandType: data.brandType ?? brandType,
        brand: brand ?? brand,
      );

  factory AppCodesArray.fromJson(Map<String, dynamic> json) => AppCodesArray(
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

  Map<String, dynamic> toJson() => {
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
