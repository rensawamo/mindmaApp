import 'package:mindmapapp/core/enum/firebase_auth_error.dart';

String exceptionMessage(FirebaseAuthResultStatus result) {
  String? message = '';
  switch (result) {
    case FirebaseAuthResultStatus.Successful:
      message = 'ログインに成功しました。';
      break;
    case FirebaseAuthResultStatus.EmailAlreadyExists:
      message = '指定されたメールアドレスは既に使用されています。';
      break;
    case FirebaseAuthResultStatus.WrongPassword:
      message = 'パスワードが違います。';
      break;
    case FirebaseAuthResultStatus.InvalidEmail:
      message = 'メールアドレスが不正です。';
      break;
    case FirebaseAuthResultStatus.UserNotFound:
      message = '指定されたユーザーは存在しません。';
      break;
    case FirebaseAuthResultStatus.UserDisabled:
      message = '指定されたユーザーは無効です。';
      break;
    case FirebaseAuthResultStatus.OperationNotAllowed:
      message = '指定されたユーザーはこの操作を許可していません。';
      break;
    case FirebaseAuthResultStatus.TooManyRequests:
      message = '指定されたユーザーはこの操作を許可していません。';
      break;
    case FirebaseAuthResultStatus.Undefined:
      message = '不明なエラーが発生しました。';
      break;
  }
  return message;
}