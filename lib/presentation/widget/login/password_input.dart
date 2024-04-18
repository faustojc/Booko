import 'package:booko/presentation/bloc/auth/login/login_bloc.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          key: const Key('login_password_input'),
          initialValue: state.password,
          style: const TextStyle(color: Colors.white),
          obscureText: !state.isObscure,
          validator: (password) {
            if (password == null || password.isEmpty) {
              context.read<LoginBloc>().add(LoginOnPasswordChanged(password!.trim(), false));
              return 'Password field cannot be empty';
            } else if (password.length < 6) {
              context.read<LoginBloc>().add(LoginOnPasswordChanged(password.trim(), false));
              return 'Password must be at least 6 characters';
            }

            context.read<LoginBloc>().add(LoginOnPasswordChanged(password.trim(), true));
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.key_outlined, color: ThemeColor.surfaceVariant),
            suffixIcon: state.isObscure
                ? IconButton(
                    icon: const Icon(Icons.visibility_off, color: ThemeColor.surfaceVariant),
                    onPressed: () => context.read<LoginBloc>().add(LoginToggleObscure(false)),
                  )
                : IconButton(
                    icon: const Icon(Icons.visibility, color: ThemeColor.surfaceVariant),
                    onPressed: () => context.read<LoginBloc>().add(LoginToggleObscure(true)),
                  ),
            hintText: 'Enter your password',
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.surfaceVariant),
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
