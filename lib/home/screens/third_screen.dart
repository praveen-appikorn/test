import 'package:appikorn_madix_widgets/appikorn_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:test/home/providers/common_provider.dart';
import 'package:test/home/screens/home_screen.dart';

final counterProviderTwo =
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

class ThirdScreen extends ConsumerWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return Column(
                  children: [
                    Text(ref.watch(incProvider).toString()),
                    appikorn_text_field(
                      initialValue: ref.watch(counterProviderTwo).name,
                      widget_key: GlobalKey<FormFieldState<String>>(),
                      formKey: GlobalKey<FormFieldState<String>>(),
                      onSaved: (val) {
                        ref.watch(counterProviderTwo.notifier).update(val!);
                      },
                    ),
                    // appikorn_text_field(
                    //   initialValue: ref.watch(userProvider).secondName,
                    //   widget_key: GlobalKey<FormFieldState<String>>(),
                    //   formKey: GlobalKey<FormFieldState<String>>(),
                    //   onSaved: (val) {
                    //     ref.read(userProvider.notifier).update(
                    //           User(secondName: val ?? ""),
                    //         );
                    //   },
                    // ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Routemaster.of(context).push('/second');
                          },
                          child: const Text("Back "),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Routemaster.of(context).push('/');
                          },
                          child: const Text("Next Screen ➡️"),
                        )
                      ],
                    )
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
