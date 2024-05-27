import 'package:appikorn_madix_widgets/appikorn_dropdown_searchable_text_field/appikorn_dropdown_searchable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/home/controller/home_controller.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   ref.read(homeControllerProvider).getMakeData(context, ref);
  // }

  @override
  Widget build(BuildContext context) {
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch data after the UI is built
      ref.read(homeControllerProvider).getMakeData(context, ref);
    });

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
                    // first drop down
                    appikorn_dropdown_searchable_text_field(
                      context: context,
                      widget_key: GlobalKey<FormFieldState<String>>(),
                      list: ref.watch(makeDescList),
                      lable: ref.watch(makeLoader)
                          ? "Give a minute 😁"
                          : "Make Vehicle",
                      controller: "",
                      onChanged: (val) {
                        if (val.isEmpty) return;

                        final String refCode = ref
                            .watch(homeControllerProvider)
                            .getRefCode(val, ref)
                            .code;

                        ref
                            .watch(homeControllerProvider)
                            .getModelData(context, ref, refCode);
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    // Second drop-down
                    appikorn_dropdown_searchable_text_field(
                      context: context,
                      widget_key: GlobalKey<FormFieldState<String>>(),
                      list: ref.watch(modelDescList),
                      lable: ref.watch(modelLoader)
                          ? "Give a minute 😁"
                          : "Car Model",
                      controller: "",
                      onChanged: (val) {
                        print(val);
                      },
                    ),
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
