import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/home/screens/test_model.dart';
import 'package:test/main.dart';

// hydrated

// abstract mixin class AppikornHydrated<T> {
//   String get key;

//   T fromJson(Map<String, dynamic> json);

//   Map<String, dynamic> toJson(T state);
// }

//  middle

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

// UI

final userProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) {
    return UserNotifier(ref, User());
  },
);

class UserNotifier extends AppikornStateNotifier<User> {
  UserNotifier(super.ref, super.state);

  @override
  String get key => runtimeType.toString();

  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(User state) {
    return state.toJson();
  }

  void update(User state) {
    super.store(state);
  }
}
