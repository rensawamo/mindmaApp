import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/login/login_view_model.dart';

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
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(provider.isLogin ? 'サインイン' : 'サインアップ',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email Address'),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.trim().isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
              onChanged: (value) {
                provider.setEmail(value);
              },
            ),
            // You can add more widgets as children here
          ],
        );
      },
    );
  }
}
