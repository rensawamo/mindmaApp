import 'package:flutter/material.dart';
import 'package:mindmapapp/view_model/login/login_view_model.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'core/routes/routes.dart';
import 'core/routes/routes_name.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Life Mind',

        // this is the initial route indicating from where our app will start
        initialRoute: RoutesName.launch,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
