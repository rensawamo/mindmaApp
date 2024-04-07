import 'package:firebase_auth/firebase_auth.dart';
import 'package:mindmapapp/core/enum/firebase_auth_error.dart';


FirebaseAuthResultStatus handleException(FirebaseAuthException e) {
  FirebaseAuthResultStatus result;
  switch (e.code) {
    case 'weak-password':
      result = FirebaseAuthResultStatus.weakpassword;
      break;
    case 'invalid-credential' :
      result = FirebaseAuthResultStatus.InvalidCredential;
      break;
    case 'invalid-email':
      result = FirebaseAuthResultStatus.InvalidEmail;
      break;
    case 'wrong-password':
      result = FirebaseAuthResultStatus.WrongPassword;
      break;
    case 'user-disabled':
      result = FirebaseAuthResultStatus.UserDisabled;
      break;
    case 'user-not-found':
      result = FirebaseAuthResultStatus.UserNotFound;
      break;
    case 'operation-not-allowed':
      result = FirebaseAuthResultStatus.OperationNotAllowed;
      break;
    case 'too-many-requests':
      result = FirebaseAuthResultStatus.TooManyRequests;
      break;
    case 'email-already-in-use':
      result = FirebaseAuthResultStatus.EmailAlreadyExists;
      break;
    default:
      result = FirebaseAuthResultStatus.Undefined;
  }
  return result;
}
