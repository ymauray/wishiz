import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wishiz/l10n.dart';
import 'package:wishiz/page/login_page/login_page_state.dart';
import 'package:wishiz/page/tab_page/tab_page.dart';
import 'package:wishiz/provider/firebase_service.dart';
import 'package:wishiz/provider/shared_preferences_service.dart';
import 'package:wishiz/service/firebase_service.dart';
import 'package:wishiz/widget/app_name.dart';
import 'package:wishiz/widget/widget_utils.dart';

class LoginPage extends ConsumerWidget with WidgetUtils {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginPageStateNotifierProvider);

    final mq = MediaQuery.of(context);
    final sizePadding = mq.size.width < 400 ? 32.0 : 64.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: FormBuilder(
              initialValue: {
                'email': ref.read(sharedPreferencesServiceProvider).email
              },
              key: _formKey,
              child: Column(
                children: [
                  topMargin(mq),
                  const AppName(),
                  margin(),
                  formTitle(state, context),
                  emailField(sizePadding, context),
                  passwordField(sizePadding, context, state),
                  if (state.isCreateAccountForm)
                    passwordConfirmationField(sizePadding, context, state),
                  margin(),
                  submitButton(state, context, ref),
                  if (!state.isCreateAccountForm) ...[
                    margin(),
                    forgotPasswordLink(context),
                  ],
                  margin(),
                  if (!state.isCreateAccountForm)
                    createAccountLink(ref, context),
                  if (state.isCreateAccountForm) ...[
                    loginLink(ref, context),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextButton loginLink(WidgetRef ref, BuildContext context) {
    return TextButton(
      onPressed: () {
        _formKey.currentState?.reset();
        ref
            .read(loginPageStateNotifierProvider.notifier)
            .toggleCreateAccountForm();
      },
      child: Text(context.t.login),
    );
  }

  TextButton createAccountLink(WidgetRef ref, BuildContext context) {
    return TextButton(
      onPressed: () {
        _formKey.currentState?.reset();
        ref
            .read(loginPageStateNotifierProvider.notifier)
            .toggleCreateAccountForm();
      },
      child: Text(context.t.createAccount),
    );
  }

  TextButton forgotPasswordLink(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(context.t.forgotPassword),
    );
  }

  ElevatedButton submitButton(
    LoginPageState state,
    BuildContext context,
    WidgetRef ref,
  ) {
    return ElevatedButton(
      child: Text(
        state.isCreateAccountForm ? context.t.createAccount : context.t.login,
      ),
      onPressed: () async {
        _formKey.currentState?.validate();
        if (state.isCreateAccountForm) {
          await createAccount(context, ref);
        } else {
          await login(context, ref);
        }
      },
    );
  }

  Future<void> login(BuildContext context, WidgetRef ref) async {
    final email = _formKey.currentState?.fields['email']?.value as String;
    final response = await ref.read(firebaseServiceProvider).login(
          email: email,
          password: _formKey.currentState?.fields['password']?.value as String,
        );
    if (response.status != ResponseStatus.success) {
      errorSnack(context, firebaseErrorMessage(context, response));
    } else {
      resetNavigation(context, (context) => const TabPage());
      successSnack(context, context.t.successfullyLoggedIn);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
    }
  }

  Future<void> createAccount(BuildContext context, WidgetRef ref) async {
    final response = await ref.read(firebaseServiceProvider).registerAccount(
          email: _formKey.currentState?.fields['email']?.value as String,
          password: _formKey.currentState?.fields['password']?.value as String,
        );
    if (response.status != ResponseStatus.success) {
      errorSnack(context, firebaseErrorMessage(context, response));
    } else {
      successSnack(context, context.t.accountSuccessfullyCreated);
      resetNavigation(context, (context) => const TabPage());
    }
  }

  Padding passwordConfirmationField(
    double sizePadding,
    BuildContext context,
    LoginPageState state,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: sizePadding,
        vertical: 8,
      ),
      child: FormBuilderTextField(
        name: 'passwordConfirmation',
        obscureText: true,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: context.t.confirmPassword,
          prefixIcon: const Icon(Icons.password),
        ),
        validator: FormBuilderValidators.compose(
          [
            FormBuilderValidators.required(),
            (val) {
              if (!state.isCreateAccountForm) return null;
              if (_formKey.currentState?.fields['password']?.value != val) {
                return context.t.passwordsDontMatch;
              }
              return null;
            },
          ],
        ),
      ),
    );
  }

  Padding passwordField(
    double sizePadding,
    BuildContext context,
    LoginPageState state,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: sizePadding,
        vertical: 8,
      ),
      child: FormBuilderTextField(
        name: 'password',
        obscureText: true,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: context.t.password,
          prefixIcon: const Icon(Icons.password),
        ),
        validator: FormBuilderValidators.compose(
          [
            FormBuilderValidators.required(),
            (val) {
              if (!state.isCreateAccountForm) return null;
              if (_formKey
                      .currentState?.fields['passwordConfirmation']?.value !=
                  val) {
                return context.t.passwordsDontMatch;
              }
              return null;
            },
          ],
        ),
      ),
    );
  }

  Padding emailField(double sizePadding, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: sizePadding,
        vertical: 8,
      ),
      child: FormBuilderTextField(
        name: 'email',
        autocorrect: false,
        decoration: InputDecoration(
          labelText: context.t.email,
          prefixIcon: const Icon(Icons.email),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
        ]),
      ),
    );
  }

  Text formTitle(LoginPageState state, BuildContext context) {
    return Text(
      state.isCreateAccountForm
          ? context.t.createAccount.toUpperCase()
          : context.t.login.toUpperCase(),
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  SizedBox margin() {
    return const SizedBox(
      height: 24,
    );
  }

  SizedBox topMargin(MediaQueryData mq) {
    return SizedBox(
      height: mq.size.height < 700 ? 48 : 72,
    );
  }
}
