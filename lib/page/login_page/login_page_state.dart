import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_page_state.freezed.dart';
part 'login_page_state.g.dart';

@freezed
class LoginPageState with _$LoginPageState {
  const factory LoginPageState({
    @Default(false) bool isCreateAccountForm,
  }) = _LoginPageState;
  factory LoginPageState.fromJson(Map<String, dynamic> json) =>
      _$LoginPageStateFromJson(json);
}

@riverpod
class LoginPageStateNotifier extends _$LoginPageStateNotifier {
  @override
  LoginPageState build() {
    return const LoginPageState();
  }

  void toggleCreateAccountForm() {
    state = state.copyWith(isCreateAccountForm: !state.isCreateAccountForm);
  }
}
