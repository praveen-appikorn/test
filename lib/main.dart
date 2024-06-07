import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:test/home/logger_riverpod.dart';
import 'package:test/home/screens/home_screen.dart';
import 'package:test/home/screens/second_screen.dart';
import 'package:test/home/screens/third_screen.dart';

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    return FlutterSecureStorage(
      aOptions: getAndroidOptions(),
    );
  },
);

void main() async {
  runApp(
    const ProviderScope(
      observers: [
        // LoggerRiverpod(),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) => routes),
      routeInformationParser: const RoutemasterParser(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

final routes = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: MyHomePage()),
  '/second': (_) => const MaterialPage(child: SecondScreen()),
  '/third': (_) => const MaterialPage(child: ThirdScreen()),
});
