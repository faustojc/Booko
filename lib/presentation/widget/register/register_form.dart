import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/domain/routes/route.dart';
import 'package:booko/presentation/widget/register/register_birthday_input.dart';
import 'package:booko/presentation/widget/register/register_button.dart';
import 'package:booko/presentation/widget/register/register_confirm_password_input.dart';
import 'package:booko/presentation/widget/register/register_email_input.dart';
import 'package:booko/presentation/widget/register/register_firstname_input.dart';
import 'package:booko/presentation/widget/register/register_lastname_input.dart';
import 'package:booko/presentation/widget/register/register_password_input.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AutoSizeText('First Name', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        const RegisterFirstnameInput(),
        const SizedBox(height: 30),
        const AutoSizeText('Last Name', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        const RegisterLastnameInput(),
        const SizedBox(height: 30),
        const AutoSizeText('Birthday', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        const RegisterBirthdayInput(),
        const SizedBox(height: 30),
        const AutoSizeText('Email', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        const RegisterEmailInput(),
        const SizedBox(height: 30),
        const AutoSizeText('Password', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        const RegisterPasswordInput(),
        const SizedBox(height: 30),
        const AutoSizeText('Confirm Password', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        const RegisterConfirmPasswordInput(),
        const SizedBox(height: 40),
        const SizedBox(
          width: double.infinity,
          child: RegisterButton(),
        ),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const AutoSizeText('Already have an account?', style: TextStyle(color: Colors.white, fontSize: 14)),
          TextButton(
            onPressed: () => Navigator.push(context, Routes.login()),
            child: const AutoSizeText('Login', style: TextStyle(color: ThemeColor.secondary, fontSize: 14)),
          )
        ])
      ],
    );
  }
}
