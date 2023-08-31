import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

enum ResponseStatus { success, error }

class Response<T> {
  Response({
    required this.data,
    required this.status,
    this.errorMessage,
    this.errorCode,
  });

  Response.success(T data)
      : this(
          data: data,
          status: ResponseStatus.success,
        );

  Response.error(String errorCode, String? errorMessage)
      : this(
          data: null,
          status: ResponseStatus.error,
          errorMessage: errorMessage,
          errorCode: errorCode,
        );

  final T? data;
  final ResponseStatus status;
  final String? errorMessage;
  final String? errorCode;
}

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Response<UserCredential>> registerAccount({
    required String email,
    required String password,
  }) async {
    return await guard(
      () async => await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<Response<UserCredential>> login({
    required String email,
    required String password,
  }) async {
    return await guard(
      () async => await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<Response<void>> logout() async {
    return await guard(() async => _auth.signOut());
  }

  Future<Response<T>> guard<T>(Future<T> Function() callback) async {
    try {
      final result = await callback();
      return Response.success(result);
    } on FirebaseException catch (e) {
      debugPrint('Error: $e');
      return Response.error(e.code, e.message);
    } catch (e) {
      debugPrint('Error: $e');
      return Response.error('exception', e.toString());
    }
  }
}
