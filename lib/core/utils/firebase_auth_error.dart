import 'package:mindmapapp/core/enum/firebase_auth_error.dart';

String exceptionMessage(FirebaseAuthResultStatus result) {
  String message = '';
  switch (result) {
    case FirebaseAuthResultStatus.weakpassword:
      message = 'パスワードが短かすぎます。';
      break;
    case FirebaseAuthResultStatus.InvalidCredential:
      message = 'メールアドレスとパスワードを正しく入力してください。';
      break;
    case FirebaseAuthResultStatus.InvalidEmail:
      message = 'メールアドレスを正しく入力してください。';
      break;

    case FirebaseAuthResultStatus.WrongPassword:
      message = 'パスワードが間違っています。';
      break;

    case FirebaseAuthResultStatus.UserNotFound:
      message = 'このアカウントは存在しません。';
      break;

    case FirebaseAuthResultStatus.UserDisabled:
      message = 'このメールアドレスは無効になっています。';
      break;

    case FirebaseAuthResultStatus.TooManyRequests:
      message = 'リクエストが多すぎます。しばらくしてから再度お試しください。';
      break;

    case FirebaseAuthResultStatus.OperationNotAllowed:
      message = 'メールアドレスとパスワードでのログインは有効になっていません。';
      break;

    case FirebaseAuthResultStatus.EmailAlreadyExists:
      message = 'このメールアドレスはすでに登録されています。';
      break;

    default:
      message = '予期せぬエラーが発生しました。';
      break;
  }
  return message;
}