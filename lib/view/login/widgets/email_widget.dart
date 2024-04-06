import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mindmapapp/view_model/login/login_view_model.dart';
import 'package:mindmapapp/core/design/app_texts.dart';

class InputEmailWidget extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode passwordFocusNode;

  const InputEmailWidget({
    Key? key,
    required this.focusNode,
    required this.passwordFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, ref, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(ref.isLogin ? 'サインイン' : 'サインアップ',
                  style: AppTexts.title2),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Eamil',
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    !value.contains('@')) {
                  return '正しい形式で入力してください';
                }
                return null;
              },
              onChanged: (String value) {
                ref.setEmail(value);
              },
            ),
          ],
        );
      },
    );
  }
}
