import 'package:dartz/dartz.dart';

import 'auth_failure.dart';
import 'value_objects.dart';

abstract class AuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
