import 'package:flutter/material.dart';
import 'package:mindmapapp/configs/design/color.dart';


class LoginButton extends StatelessWidget {

  final String title ;
  final bool loading ;
  final VoidCallback onPress ;
  const LoginButton({Key? key ,
    required this.title,
    this.loading = false ,
    required this.onPress ,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
            color: AppColors.blackColor,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
            child:loading ? const CircularProgressIndicator(color: Colors.white,) :
            const Text('Create an account' ,
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
