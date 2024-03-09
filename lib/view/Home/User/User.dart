import 'package:flutter/material.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.red,
      child: Center(
        child: Text("User"),
      ),
    );
  }
}
