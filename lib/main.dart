import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mindmapapp/repository/login_api/auth_http_api_repository.dart';
import 'package:mindmapapp/repository/login_api/auth_repository.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerLazySingleton<AuthRepository>(() => AuthHttpApiRepository());
  await Firebase.initializeApp();
  runApp(const App());
}