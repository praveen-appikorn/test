import 'dart:convert';

ModelSuccess demoFromMap(String str) => ModelSuccess.fromMap(json.decode(str));

String demoToMap(ModelSuccess data) => json.encode(data.toMap());

class ModelSuccess {
    List<ModelCodesArray>? appCodesArray;
    String? respCode;
    String? errMessage;

    ModelSuccess({
        this.appCodesArray,
        this.respCode,
        this.errMessage,
    });

    factory ModelSuccess.fromMap(Map<String, dynamic> json) => ModelSuccess(
        appCodesArray: json["appCodesArray"] == null ? [] : List<ModelCodesArray>.from(json["appCodesArray"]!.map((x) => ModelCodesArray.fromMap(x))),
        respCode: json["respCode"],
        errMessage: json["errMessage"],
    );

    Map<String, dynamic> toMap() => {
        "appCodesArray": appCodesArray == null ? [] : List<dynamic>.from(appCodesArray!.map((x) => x.toMap())),
        "respCode": respCode,
        "errMessage": errMessage,
    };
}

class ModelCodesArray {
    String? code;
    String? desc;
    dynamic value;
    String? descAr;
    dynamic longDesc;
    dynamic longDescBl;

    ModelCodesArray({
        this.code,
        this.desc,
        this.value,
        this.descAr,
        this.longDesc,
        this.longDescBl,
    });

    factory ModelCodesArray.fromMap(Map<String, dynamic> json) => ModelCodesArray(
        code: json["code"],
        desc: json["desc"],
        value: json["value"],
        descAr: json["descAr"],
        longDesc: json["longDesc"],
        longDescBl: json["longDescBl"],
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "desc": desc,
        "value": value,
        "descAr": descAr,
        "longDesc": longDesc,
        "longDescBl": longDescBl,
    };
}
