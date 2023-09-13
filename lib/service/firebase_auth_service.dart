import 'package:firebase_auth/firebase_auth.dart';
import 'package:wishiz/service/abstract_firebase_service.dart';
import 'package:wishiz/service/firebase_service_response.dart';

class FirebaseAuthService extends AbstractFirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseServiceResponse<UserCredential>> registerAccount({
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

  Future<FirebaseServiceResponse<UserCredential>> login({
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

  Future<FirebaseServiceResponse<void>> logout() async {
    return await guard(() async => _auth.signOut());
  }
}
