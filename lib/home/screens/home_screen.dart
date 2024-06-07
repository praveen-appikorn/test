import 'dart:async';

import 'package:appikorn_madix_widgets/appikorn_dropdown_searchable_text_field/appikorn_dropdown_searchable_text_field.dart';
import 'package:appikorn_madix_widgets/appikorn_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:test/home/controller/home_controller.dart';
// import 'package:test/home/controller/home_controller.dart';
import 'package:test/home/models/user.dart';
import 'package:test/home/providers/common_provider.dart';
import 'package:test/home/providers/make_provider.dart';
import 'package:test/home/providers/user_provider.dart';
// import 'package:test/home/screens/second_screen.dart';

final counterProvider =
    StateNotifierProvider.autoDispose<CounterNotifier, Demo>((ref) {
  return CounterNotifier(ref, Demo());
});

class Demo {
  String? name;
  Demo({this.name});
}

class CounterNotifier extends AppikornStateNotifier<Demo> {
  CounterNotifier(super.ref, super.state);

  void update(String val) {
    state = Demo(name: val);
  }

  @override
  Demo fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  String get key => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson(Demo state) {
    throw UnimplementedError();
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

final incProvider = StateProvider.autoDispose<int>(
  (ref) {
    final link = ref.keepAlive();
    final timer = Timer(
      const Duration(seconds: 10),
      () {
        link.close();
      },
    );
    ref.onDispose(
      () {
        timer.cancel();
      },
    );
    return 0;
  },
);

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.watch(homeControllerProvider).createMakeData(context, ref);
      },
    );
  }

  void fun() {
    print(ref.watch(incProvider).toString());
  }

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
                    ElevatedButton(
                      onPressed: () {
                        fun();
                      },
                      child: const Text("Call function!!"),
                    ),
                    appikorn_text_field(
                      initialValue: ref.watch(counterProvider).name,
                      widget_key: GlobalKey<FormFieldState<String>>(),
                      formKey: GlobalKey<FormFieldState<String>>(),
                      onSaved: (val) {
                        ref.watch(counterProvider.notifier).update(val!);
                      },
                    ),
                    appikorn_text_field(
                      initialValue: ref.watch(userProvider).firstName,
                      widget_key: GlobalKey<FormFieldState<String>>(),
                      formKey: GlobalKey<FormFieldState<String>>(),
                      onSaved: (val) {
                        ref.read(userProvider.notifier).update(
                              User(firstName: val ?? ""),
                            );
                      },
                    ),
                    appikorn_dropdown_searchable_text_field(
                      context: context,
                      widget_key: GlobalKey<FormFieldState<String>>(),
                      list: ref.watch(makeDescList),
                      lable: ref.watch(userProvider).make ?? "Make Vehicle",
                      controller: ref.watch(userProvider).make ?? "",
                      onChanged: (val) {
                        ref.read(userProvider.notifier).update(
                              User(make: val ?? ""),
                            );
                      },
                    ),
                    OutlinedButton(
                        onPressed: () {
                          Routemaster.of(context).push('/second');
                        },
                        child: const Text("Next Screen ➡️"))
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
