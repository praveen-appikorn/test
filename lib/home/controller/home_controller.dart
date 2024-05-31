// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test/common/utils.dart';
import 'package:test/home/models/home_model.dart';
import 'package:test/home/models/make_success.dart';
import 'package:test/home/models/model_success.dart';
import 'package:test/home/repository/home_repository.dart';

final makeLoader = StateProvider<bool>((ref) {
  return false;
});

final modelLoader = StateProvider<bool>((ref) {
  return false;
});

final homeControllerProvider = Provider(
  (ref) {
    final makeRepository = ref.watch(homeRepositoryProvider);
    return MakeController(makeRepository: makeRepository);
  },
);

final makeResProvider = StateNotifierProvider<MakeResNotifier, MakeSuccess>(
  (ref) {
    return MakeResNotifier();
  },
);

class MakeResNotifier extends StateNotifier<MakeSuccess> {
  MakeResNotifier() : super(MakeSuccess());

  void updateState(MakeSuccess data) {
    state = data;
  }
}

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
    // print("1 Model class provider inital.");
    return ModelSuccess();
  },
);

final modelAppCodeList = Provider<List<MakeState>>((ref) {
  // print("2 Model app code list....");
  final watcher = ref.watch(modelResProvider);
  if (watcher.appCodesArray == null) return [];

  return watcher.appCodesArray!.map((el) {
    return MakeState(desc: el.desc!, code: el.code!);
  }).toList();
});

final modelDescList = Provider<List<String>>((ref) {
  // print("3 Model desc code list....");
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
    final result = await _makeRepository.getMakeData();

    result.fold(
      (err) {
        // Take a look here
        showSnackBar(context, err.errMsg);
      },
      (data) {
        ref.watch(makeResProvider.notifier).updateState(data);
      },
    );
  }

  void getModelData(BuildContext context, WidgetRef ref, String refCode) async {
    final result = await _makeRepository.getModelData(refCode);

    result.fold(
      (err) {
        // Take a look here
        showSnackBar(context, err.errMsg);
      },
      (data) {
        // print("before updating Model class...");

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


/////////////////////////////////////////////////////////////////////////////////////

// class Loaders {
//   final bool loaderOne;
//   final bool loaderTwo;

//   Loaders({required this.loaderOne, required this.loaderTwo});

//   Loaders copyWith({
//     bool? loaderOne,
//     bool? loaderTwo,
//   }) {
//     return Loaders(
//       loaderOne: loaderOne ?? this.loaderOne,
//       loaderTwo: loaderTwo ?? this.loaderTwo,
//     );
//   }

//   @override
//   String toString() => 'Loaders(loaderOne: $loaderOne, loaderTwo: $loaderTwo)';
// }

// final demoProvider = Provider((ref) {
//   return Demo();
// });

// class Demo {
//   static final updateLoaderProvider = StateProvider<Loaders>(
//     (ref) {
//       print("updating loader");
//       return Loaders(loaderOne: false, loaderTwo: false);
//     },
//   );

//   static final loaderListener = StateProvider(
//     (ref) {
//       print("listening loader");
//       final x = ref.watch(Demo.updateLoaderProvider);
//       return x;
//     },
//   );

//   void updateLoaderOne(WidgetRef ref) {
//     ref.watch(Demo.updateLoaderProvider.notifier).update((state) {
//       // return state.copyWith(loaderOne: !state.loaderOne);
//       return Loaders(loaderOne: true, loaderTwo: false);
//     });

//     ref.read(Demo.loaderListener);
//   }

//   void updateLoaderTwo(WidgetRef ref) {
//     ref.watch(Demo.updateLoaderProvider.notifier).update((state) {
//       // return state.copyWith(loaderTwo: !state.loaderTwo);
//       return Loaders(loaderOne: false, loaderTwo: true);
//     });

//     ref.read(Demo.loaderListener);
//   }
// }
