import 'package:booko/presentation/bloc/auth/login/login_bloc.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          key: const Key('login_email_input'),
          initialValue: state.email,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          validator: (email) {
            if (email == null || email.isEmpty) {
              context.read<LoginBloc>().add(LoginOnEmailChanged(email!.trim(), false));
              return 'Email field cannot be empty';
            } else if (!RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$').hasMatch(email)) {
              context.read<LoginBloc>().add(LoginOnEmailChanged(email.trim(), false));
              return 'Invalid email address';
            }

            context.read<LoginBloc>().add(LoginOnEmailChanged(email.trim(), true));
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
