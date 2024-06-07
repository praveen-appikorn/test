import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/home/models/make_success.dart';
import 'package:test/home/providers/common_provider.dart';

final makeResProvider =
    StateNotifierProvider.autoDispose<MakeResNotifier, MakeSuccess>(
  (ref) {
    return MakeResNotifier(ref, MakeSuccess());
  },
);

final makeAppCodeList = Provider.autoDispose(
  (ref) {
    final res = ref.watch(makeResProvider);
    if (res.appCodesArray == null) return [];

    return res.appCodesArray!.map(
      (el) {
        return AppCodesArray(desc: el.desc!, code: el.code!);
      },
    ).toList();
  },
);

final makeDescList = Provider.autoDispose<List<String>>(
  (ref) {
    if (ref.watch(makeAppCodeList).isEmpty) return [];

    return ref.watch(makeAppCodeList).map(
      (el) {
        return el.desc as String;
      },
    ).toList();
  },
);

// class
class MakeResNotifier extends AppikornStateNotifier<MakeSuccess> {
  MakeResNotifier(super.ref, super.state);

  @override
  MakeSuccess fromJson(Map<String, dynamic> json) {
    return MakeSuccess.fromJson(json);
  }

  @override
  String get key => runtimeType.toString();

  @override
  Map<String, dynamic> toJson(MakeSuccess state) {
    return state.toJson();
  }

  void update(MakeSuccess data) {
    state = state.copyWith(data);
    // super.store(state);
  }
}
