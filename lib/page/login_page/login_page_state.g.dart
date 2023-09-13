// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_page_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginPageState _$$_LoginPageStateFromJson(Map<String, dynamic> json) =>
    _$_LoginPageState(
      isCreateAccountForm: json['isCreateAccountForm'] as bool? ?? false,
    );

Map<String, dynamic> _$$_LoginPageStateToJson(_$_LoginPageState instance) =>
    <String, dynamic>{
      'isCreateAccountForm': instance.isCreateAccountForm,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginPageStateNotifierHash() =>
    r'f7269565487c7d163cffdede420836ea028bf273';

/// See also [LoginPageStateNotifier].
@ProviderFor(LoginPageStateNotifier)
final loginPageStateNotifierProvider = AutoDisposeNotifierProvider<
    LoginPageStateNotifier, LoginPageState>.internal(
  LoginPageStateNotifier.new,
  name: r'loginPageStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginPageStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoginPageStateNotifier = AutoDisposeNotifier<LoginPageState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
