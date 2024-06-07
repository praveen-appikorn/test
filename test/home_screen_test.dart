import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:test/home/screens/home_screen.dart';
import 'package:test/main.dart';

// Mock class for flutterSecureStorageProvider
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('CounterNotifier', () {
    late MockFlutterSecureStorage mockStorage;

    setUp(
      () {
        mockStorage = MockFlutterSecureStorage();
      },
    );

    testWidgets('updates state with new name', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            flutterSecureStorageProvider.overrideWithValue(mockStorage),
          ],
          child: ConsumerWidgetTest(
            onBuild: (context, ref) {
              final notifier = ref.read(counterProvider.notifier);
              // Act
              notifier.update('John');

              // Assert
              expect(notifier.state.name, 'John');
            },
          ),
        ),
      );
    });

    testWidgets('returns correct key', (tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            flutterSecureStorageProvider.overrideWithValue(mockStorage),
          ],
          child: ConsumerWidgetTest(
            onBuild: (context, ref) {
              final notifier = ref.read(counterProvider.notifier);
              // Act & Assert
              expect(notifier.key, 'Demo');
            },
          ),
        ),
      );
    });

    // Add more tests as needed
  });
}

class ConsumerWidgetTest extends ConsumerWidget {
  final void Function(BuildContext, WidgetRef) onBuild;

  const ConsumerWidgetTest({required this.onBuild, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    onBuild(context, ref);
    return Container(); // A placeholder widget
  }
}
