import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/presentation/bloc/auth/login/login_bloc.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => curr is LoginLoading || curr is LoginSuccess || curr is LoginFailure,
      builder: (context, state) {
        if (state is LoginLoading) {
          return ElevatedButton(
              onPressed: () {},
              child: const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: ThemeColor.white),
              ));
        }

        return ElevatedButton(
          onPressed: () => context.read<LoginBloc>().add(LoginRequesting()),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ThemeColor.primary),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14)))),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: AutoSizeText('Login', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        );
      },
    );
  }
}
