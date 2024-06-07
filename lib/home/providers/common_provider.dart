import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test/main.dart';

abstract class AppikornStateNotifier<T> extends StateNotifier<T> {
  final Ref ref;

  AppikornStateNotifier(this.ref, super.state) {
    hyderate();
  }

  T fromJson(Map<String, dynamic> json);

  String get key;

  Map<String, dynamic> toJson(T state); 

  void hyderate() async {
    final value = await ref.watch(flutterSecureStorageProvider).read(key: key);
    if (value != null) {
      Map<String, dynamic> jsonValue = json.decode(value);
      T ins = fromJson(jsonValue);
      state = ins;
    } else {
      state = state;
    }
  }

  void store(T state) async {
    Map<String, dynamic> value = toJson(state);
    String encVal = json.encode(value);
    await ref
        .watch(flutterSecureStorageProvider)
        .write(key: key, value: encVal);
  }
}
