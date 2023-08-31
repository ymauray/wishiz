import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state.g.dart';

enum AuthStateEnum {
  waiting,
  notLoggedIn,
  loggedIn,
}

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  User? user;

  @override
  AuthStateEnum build() {
    return AuthStateEnum.waiting;
  }

  void setUser(User? user) {
    this.user = user;
    state = user == null ? AuthStateEnum.notLoggedIn : AuthStateEnum.loggedIn;
  }
}
