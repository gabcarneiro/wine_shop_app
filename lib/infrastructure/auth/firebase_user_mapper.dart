import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../domain/auth/user.dart';

extension FirebaseUserDomainX on fb.User {
  User toDomain() {
    return User(
      id: uid,
    );
  }
}
