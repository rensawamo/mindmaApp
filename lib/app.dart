import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mindmapapp/view_model/Home/phylogenetic/Phylogenetic_view_model.dart';
import 'package:mindmapapp/view_model/launch/launch_view_model.dart';
import 'package:mindmapapp/view_model/login/login_view_model.dart';
import 'package:provider/provider.dart';

import 'configs/routes/routes.dart';
import 'configs/routes/routes_name.dart';
import 'flavors.dart';
import 'main.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // this is the initial route indicating from where our app will start
        initialRoute: RoutesName.launch,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
