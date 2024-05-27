import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/common/utils.dart';
import 'package:test/home/models/home_model.dart';
import 'package:test/home/models/make_success.dart';
import 'package:test/home/models/model_success.dart';
import 'package:test/home/repository/home_repository.dart';

final makeLoader = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final modelLoader = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final homeControllerProvider = Provider(
  (ref) {
    final makeRepository = ref.watch(homeRepositoryProvider);
    return MakeController(makeRepository: makeRepository);
  },
);

final makeResProvider = StateProvider<MakeSuccess>(
  (ref) {
    return MakeSuccess();
  },
);

final makeAppCodeList = Provider<List<MakeState>>((ref) {
  final watcher = ref.watch(makeResProvider);
  if (watcher.appCodesArray == null) return [];

  return watcher.appCodesArray!.map((el) {
    return MakeState(desc: el.desc!, code: el.code!);
  }).toList();
});

final makeDescList = Provider<List<String>>((ref) {
  if (ref.watch(makeAppCodeList).isEmpty) return [];

  return ref.watch(makeAppCodeList).map((el) {
    return el.desc;
  }).toList();
});

// /////

final modelResProvider = StateProvider<ModelSuccess>(
  (ref) {
    return ModelSuccess();
  },
);

final modelAppCodeList = Provider<List<MakeState>>((ref) {
  final watcher = ref.watch(modelResProvider);
  if (watcher.appCodesArray == null) return [];

  return watcher.appCodesArray!.map((el) {
    return MakeState(desc: el.desc!, code: el.code!);
  }).toList();
});

final modelDescList = Provider<List<String>>((ref) {
  if (ref.watch(modelAppCodeList).isEmpty) return [];

  return ref.watch(modelAppCodeList).map((el) {
    return el.desc;
  }).toList();
});

class MakeController {
  final HomeRepository _makeRepository;

  MakeController({required HomeRepository makeRepository})
      : _makeRepository = makeRepository;

  void getMakeData(BuildContext context, WidgetRef ref) async {
    ref.read(makeLoader.notifier).update((state) {
      return true;
    });

    final result = await _makeRepository.getMakeData();

    ref.read(makeLoader.notifier).update((state) {
      return false;
    });

    result.fold(
      (err) {
        // Take a look here
        showSnackBar(context, err.errMsg);
      },
      (data) {
        ref.watch(makeResProvider.notifier).update(
          (state) {
            return data;
          },
        );
      },
    );
  }

  void getModelData(BuildContext context, WidgetRef ref, String refCode) async {
    ref.read(modelLoader.notifier).update((state) {
      return true;
    });

    final result = await _makeRepository.getModelData(refCode);

    ref.read(modelLoader.notifier).update((state) {
      return false;
    });

    result.fold(
      (err) {
        // Take a look here
        showSnackBar(context, err.errMsg);
      },
      (data) {
        ref.watch(modelResProvider.notifier).update(
          (state) {
            return data;
          },
        );
      },
    );
  }

  MakeState getRefCode(String desc, WidgetRef ref) {
    return ref.watch(makeAppCodeList).firstWhere(
      (el) {
        return el.desc == desc;
      },
    );
  }
}
