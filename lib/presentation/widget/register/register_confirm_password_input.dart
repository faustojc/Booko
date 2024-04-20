import 'package:booko/presentation/bloc/auth/register/register_cubit.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterConfirmPasswordInput extends StatelessWidget {
  const RegisterConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: Colors.white),
          obscureText: state.isConfirmPasswordObscure,
          validator: (password) {
            if (password == null || password.isEmpty) {
              context.read<RegisterCubit>().onInputChanged(confirmPassword: password!.trim(), isConfirmPasswordValid: false);
              return 'Password field cannot be empty';
            }

            if (password.length < 6) {
              context.read<RegisterCubit>().onInputChanged(confirmPassword: password.trim(), isConfirmPasswordValid: false);
              return 'Password must be at least 6 characters';
            }

            if (password != state.password) {
              context.read<RegisterCubit>().onInputChanged(confirmPassword: password.trim(), isConfirmPasswordValid: false);
              return 'Passwords do not match';
            }

            context.read<RegisterCubit>().onInputChanged(confirmPassword: password.trim(), isConfirmPasswordValid: true);
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.key_outlined, color: ThemeColor.surfaceVariant),
            suffixIcon: state.isConfirmPasswordObscure
                ? IconButton(
                    icon: const Icon(Icons.visibility_off, color: ThemeColor.surfaceVariant),
                    onPressed: () => context.read<RegisterCubit>().onPasswordObscureChanged(isConfirmPasswordObscure: false),
                  )
                : IconButton(
                    icon: const Icon(Icons.visibility, color: ThemeColor.surfaceVariant),
                    onPressed: () => context.read<RegisterCubit>().onPasswordObscureChanged(isConfirmPasswordObscure: true),
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
