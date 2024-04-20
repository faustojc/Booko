import 'package:booko/presentation/bloc/auth/register/register_cubit.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPasswordInput extends StatelessWidget {
  const RegisterPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: Colors.white),
          obscureText: state.isPasswordObscure,
          validator: (password) {
            if (password == null || password.isEmpty) {
              context.read<RegisterCubit>().onInputChanged(password: password!.trim(), isPasswordValid: false);
              return 'Password field cannot be empty';
            }

            if (password.length < 6) {
              context.read<RegisterCubit>().onInputChanged(password: password.trim(), isPasswordValid: false);
              return 'Password must be at least 6 characters';
            }

            if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9]).{6,}$').hasMatch(password)) {
              context.read<RegisterCubit>().onInputChanged(password: password.trim(), isPasswordValid: false);
              return 'At least one uppercase letter and one number';
            }

            context.read<RegisterCubit>().onInputChanged(password: password.trim(), isPasswordValid: true);
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.key_outlined, color: ThemeColor.surfaceVariant),
            suffixIcon: state.isPasswordObscure
                ? IconButton(
                    icon: const Icon(Icons.visibility_off, color: ThemeColor.surfaceVariant),
                    onPressed: () => context.read<RegisterCubit>().onPasswordObscureChanged(isPasswordObscure: false),
                  )
                : IconButton(
                    icon: const Icon(Icons.visibility, color: ThemeColor.surfaceVariant),
                    onPressed: () => context.read<RegisterCubit>().onPasswordObscureChanged(isPasswordObscure: true),
                  ),
            hintText: 'Enter your password',
            hintStyle: const TextStyle(color: ThemeColor.surfaceVariant),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              borderSide: BorderSide(color: Colors.white, width: 2.5),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              borderSide: BorderSide(width: 2.5),
            ),
          ),
        );
      },
    );
  }
}
