
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test/home/models/user.dart';
import 'package:test/home/providers/common_provider.dart';

// UI

final userProvider = StateNotifierProvider.autoDispose<UserNotifier, User>(
  (ref) {
    return UserNotifier(ref, User());
  },
);

class UserNotifier extends AppikornStateNotifier<User> {
  UserNotifier(super.ref, super.state);

  @override
  String get key => runtimeType.toString();

  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(User state) {
    return state.toJson();
  }

  void update(User user) {
    state = state.copyWith(user);
    // super.store(state);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
