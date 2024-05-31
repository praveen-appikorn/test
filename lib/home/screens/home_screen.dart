import 'package:appikorn_madix_widgets/appikorn_dropdown_searchable_text_field/appikorn_dropdown_searchable_text_field.dart';
import 'package:appikorn_madix_widgets/appikorn_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/home/controller/home_controller.dart';
import 'package:test/home/screens/test_model.dart';
import 'package:test/home/screens/test_screen.dart';
import 'package:test/main.dart';

// final useSelectedMakeProvider = StateNotifierProvider<DummyNotifier, String>(
//   (ref) {
//     return DummyNotifier();
//   },
// );

// class DummyNotifier extends StateNotifier<String> {
//   DummyNotifier() : super("");

//   void makeUserSelected(WidgetRef ref) async {
//     String data =
//         await ref.watch(flutterSecureStorageProvider).read(key: "makeKey") ??
//             "";
//     state = data;
//   }
// }

// final userNameProvider = StateNotifierProvider<UserNameNotifier, String>(
//   (ref) {
//     return UserNameNotifier();
//   },
// );

// class UserNameNotifier extends StateNotifier<String> {
//   UserNameNotifier() : super("");

//   void readName(WidgetRef ref) async {
//     String value =
//         await ref.watch(flutterSecureStorageProvider).read(key: "username") ??
//             "";
//     state = value;
//   }
// }

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Test Screen!"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return Column(
                  children: [
                    appikorn_text_field(
                      initialValue: ref.watch(userProvider).firstName,
                      widget_key: GlobalKey<FormFieldState<String>>(),
                      formKey: GlobalKey<FormFieldState<String>>(),
                      onSaved: (val) {
                        ref.watch(userProvider.notifier).update(
                              User(firstName: val ?? ""),
                            );
                      },
                    ),

                    // const SizedBox(
                    //   height: 50,
                    // ),
                    // appikorn_dropdown_searchable_text_field(
                    //   context: context,
                    //   widget_key: GlobalKey<FormFieldState<String>>(),
                    //   list: ref.watch(makeDescList),
                    //   lable: ref.watch(useSelectedMakeProvider).isEmpty
                    //       ? "Make Vehicle"
                    //       : ref.watch(useSelectedMakeProvider),
                    //   controller: ref.watch(useSelectedMakeProvider).isEmpty
                    //       ? ""
                    //       : ref.watch(useSelectedMakeProvider),
                    //   onChanged: (val) async {
                    //     if (val.isEmpty) return;

                    //     // await ref
                    //     //     .watch(flutterSecureStorageProvider)
                    //     //     .write(key: "makeKey", value: val);

                    //     ref
                    //         .watch(superNotifierProvider.notifier)
                    //         .updateUserName("makeKey", val);

                    //     final String refCode = ref
                    //         .watch(homeControllerProvider)
                    //         .getRefCode(val, ref)
                    //         .code;

                    //     ref
                    //         .watch(homeControllerProvider)
                    //         .getModelData(context, ref, refCode);
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 50,
                    // ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


// ///////////////////////////////////////////////////

// Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Consumer(
//               builder: (context, ref, child) {
//                 return Column(
//                   children: [
//                     // first drop down
//                     appikorn_dropdown_searchable_text_field(
//                       context: context,
//                       widget_key: GlobalKey<FormFieldState<String>>(),
//                       list: ref.watch(makeDescList),
//                       lable: ref.watch(makeLoader)
//                           ? "Give a minute 😁"
//                           : "Make Vehicle",
//                       controller: "",
//                       onChanged: (val) {
//                         if (val.isEmpty) return;

//                         final String refCode = ref
//                             .watch(homeControllerProvider)
//                             .getRefCode(val, ref)
//                             .code;

//                         ref
//                             .watch(homeControllerProvider)
//                             .getModelData(context, ref, refCode);
//                       },
//                     ),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     // Second drop-down
//                     appikorn_dropdown_searchable_text_field(
//                       context: context,
//                       widget_key: GlobalKey<FormFieldState<String>>(),
//                       list: ref.watch(modelDescList),
//                       lable: ref.watch(modelLoader)
//                           ? "Give a minute 😁"
//                           : "Car Model",
//                       controller: "",
//                       onChanged: (val) {
//                         print(val);
//                       },
//                     ),
//                   ],
//                 );
//               },
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             Row(
//               children: [
//                 ref.watch(Demo.loaderListener).loaderOne
//                     ? const CircularProgressIndicator(
//                         color: Colors.amber,
//                       )
//                     : const Text(""),
//                 const SizedBox(
//                   width: 60,
//                 ),
//                 ref.watch(Demo.loaderListener).loaderTwo
//                     ? const CircularProgressIndicator(
//                         color: Colors.green,
//                       )
//                     : const Text(""),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 OutlinedButton(
//                   onPressed: () {
//                     ref.watch(demoProvider).updateLoaderOne(ref);
//                   },
//                   child: const Text("First Loader"),
//                 ),
//                 OutlinedButton(
//                   onPressed: () {
//                     ref.watch(demoProvider).updateLoaderTwo(ref);
//                   },
//                   child: const Text("Second Loader"),
//                 ),
//               ],
//             )
//           ],
//         ),
     
// //////////////////////////////////////////////////////////////
