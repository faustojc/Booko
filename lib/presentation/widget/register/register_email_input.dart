import 'package:booko/presentation/bloc/auth/register/register_cubit.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterEmailInput extends StatelessWidget {
  const RegisterEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          validator: (email) {
            if (email == null || email.isEmpty) {
              context.read<RegisterCubit>().onInputChanged(email: email!.trim(), isEmailValid: false);
              return 'Email field cannot be empty';
            }

            if (!RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$').hasMatch(email)) {
              context.read<RegisterCubit>().onInputChanged(email: email.trim(), isEmailValid: false);
              return 'Invalid email address';
            }

            context.read<RegisterCubit>().onInputChanged(email: email.trim(), isEmailValid: true);
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email_outlined, color: ThemeColor.surfaceVariant),
            hintText: 'Enter your email',
            hintStyle: TextStyle(color: ThemeColor.surfaceVariant),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              borderSide: BorderSide(color: Colors.white, width: 2.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              borderSide: BorderSide(width: 2.5),
            ),
          ),
        );
      },
    );
  }
}
