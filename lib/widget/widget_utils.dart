import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishiz/l10n.dart';
import 'package:wishiz/service/firebase_service_response.dart';

mixin WidgetUtils on ConsumerWidget {
  void _snackMessage(BuildContext context, String message, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  void successSnack(BuildContext context, String message) {
    _snackMessage(context, message, true);
  }

  void errorSnack(BuildContext context, String message) {
    _snackMessage(context, message, false);
  }

  String firebaseErrorMessage<T>(
    BuildContext context,
    FirebaseServiceResponse<T> response,
  ) {
    if (response.status == FirebaseServiceResponseStatus.success) {
      return '';
    } else {
      switch (response.errorCode) {
        case 'user-not-found':
          return context.t.userNotFound;
        case 'wrong-password':
          return context.t.wrongPassword;
        //case 'wrong-password':
        //  return context.t.wrongPassword;
        case 'email-already-in-use':
          return context.t.emailAlreadyInUse;
        //case 'invalid-email':
        //  return context.t.invalidEmail;
        case 'weak-password':
          return context.t.weakPassword;
        //case 'too-many-requests':
        //  return context.t.tooManyRequests;
        //case 'operation-not-allowed':
        //  return context.t.operationNotAllowed;
        default:
          return '${response.errorCode} - ${response.errorMessage}';
      }
    }
  }

  void resetNavigation<T extends Widget>(
    BuildContext context,
    T Function(BuildContext) builder,
  ) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<T>(
        builder: builder,
      ),
      (route) => false,
    );
  }
}
