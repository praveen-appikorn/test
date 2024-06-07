// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/common/utils.dart';
import 'package:test/home/models/home_model.dart';
import 'package:test/home/models/model_success.dart';
import 'package:test/home/providers/make_provider.dart';
import 'package:test/home/repository/home_repository.dart';

final homeControllerProvider = Provider.autoDispose(
  (ref) {
    final makeRepository = ref.watch(homeRepositoryProvider);
    return HomeController(homeRepository: makeRepository);
  },
);

final modelResProvider = StateProvider.autoDispose<ModelSuccess>(
  (ref) {
    return ModelSuccess();
  },
);

final modelAppCodeList = Provider.autoDispose<List<MakeState>>(
  (ref) {
    final watcher = ref.watch(modelResProvider);
    if (watcher.appCodesArray == null) return [];

    return watcher.appCodesArray!.map(
      (el) {
        return MakeState(desc: el.desc!, code: el.code!);
      },
    ).toList();
  },
);

final modelDescList = Provider.autoDispose<List<String>>(
  (ref) {
    if (ref.watch(modelAppCodeList).isEmpty) return [];

    return ref.watch(modelAppCodeList).map(
      (el) {
        return el.desc;
      },
    ).toList();
  },
);

class HomeController {
  final HomeRepository _homeRepository;

  HomeController({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  void createMakeData(BuildContext context, WidgetRef ref) async {
    final result = await _homeRepository.getMakeData();

    result.fold(
      (err) {
        // Take a look here
        showSnackBar(context, err.errMsg);
      },
      (data) {
        ref.watch(makeResProvider.notifier).update(data);
      },
    );
  }

  void getModelData(BuildContext context, WidgetRef ref, String refCode) async {
    final result = await _homeRepository.getModelData(refCode);

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
