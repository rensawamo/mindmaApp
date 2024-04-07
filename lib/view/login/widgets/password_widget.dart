import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mindmapapp/view_model/login/login_view_model.dart';


class PasswordWidget extends StatelessWidget {
  PasswordWidget({required this.focusNode, Key? key}) : super(key: key);

  final FocusNode focusNode;
  final ValueNotifier<bool> _obSecurePassword = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
        builder: (BuildContext context, LoginViewModel provider, Widget? child){
          return ValueListenableBuilder(
              valueListenable: _obSecurePassword,
              builder: (BuildContext context , bool value, Widget? child){
                return TextFormField(
                  obscureText: _obSecurePassword.value,
                  focusNode: focusNode,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_open_rounded),
                    suffixIcon: InkWell(
                        onTap: (){
                          _obSecurePassword.value = !_obSecurePassword.value ;
                        },
                        child: Icon(
                            _obSecurePassword.value ?  Icons.visibility_off_outlined :
                            Icons.visibility
                        )),
                  ),
                  onChanged: (String value){
                    provider.setPassword(value);
                  },
                );

              }
          );
        }
    );
  }
}