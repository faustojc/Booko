import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/presentation/widget/login/email_input.dart';
import 'package:booko/presentation/widget/login/login_button.dart';
import 'package:booko/presentation/widget/login/password_input.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AutoSizeText('Email', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        const EmailInput(),
        const SizedBox(height: 30),
        const AutoSizeText('Password', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        const PasswordInput(),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {},
          child: const AutoSizeText(
            'Forgot password?',
            style: TextStyle(color: ThemeColor.surfaceVariant, fontSize: 14),
          ),
        ),
        const SizedBox(height: 20),
        const SizedBox(
          width: double.infinity,
          child: LoginButton(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AutoSizeText('Don\'t have an account?', style: TextStyle(color: Colors.white, fontSize: 14)),
            TextButton(
              onPressed: () {},
              child: const AutoSizeText('Register', style: TextStyle(color: ThemeColor.secondary, fontSize: 14)),
            ),
          ],
        ),
      ],
    );
  }
}
