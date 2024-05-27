import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test/home/models/failure.dart';
import 'package:test/home/models/model_success.dart';
import 'package:test/home/models/make_success.dart';
import 'package:test/home/typedef.dart';
import 'package:http/http.dart' as http;

final homeRepositoryProvider = Provider((ref) {
  return HomeRepository();
});

class HomeRepository {
  FutureMake<MakeSuccess> getMakeData() async {
    const String url =
        "https://www.devapi.anoudapps.com/qicservices/aggregator/getApplCodes?company=100";

    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'company': '006',
          'Content-Type': 'application/json',
          'Authorization': 'Basic bW9iaWxlOm9ubGluZTEyMw=='
        },
        body: json.encode({
          "type": "MOT_VEH_MAKE",
          "filter": {"orderBy": "8"}
        }),
      );
      final Map<String, dynamic> body = json.decode(res.body);
      final MakeSuccess data = MakeSuccess.fromMap(body);
      return right(data);
    } catch (e) {
      print("inside catch block: ${e.toString()}");
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureMake<ModelSuccess> getModelData(String refCode) async {
    const String url =
        "https://www.devapi.anoudapps.com/qicservices/aggregator/getApplRefCodes?company=100";

    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'company': '006',
          'Content-Type': 'application/json',
          'Authorization': 'Basic bW9iaWxlOm9ubGluZTEyMw=='
        },
        body: json.encode({"type": "MOT_VEH_MOD", "refCode": refCode}),
      );
      final Map<String, dynamic> body = json.decode(res.body);

      final ModelSuccess modelData = ModelSuccess.fromMap(body);
      return right(modelData);
    } catch (e) {
      print("home_repository.dart (Error): ${e.toString()}");
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
