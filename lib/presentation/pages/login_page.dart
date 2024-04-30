import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:booko/domain/routes/route.dart';
import 'package:booko/presentation/bloc/auth/login/login_bloc.dart';
import 'package:booko/presentation/widget/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LoginBloc(
              authRepo: RepositoryProvider.of<AuthRepo>(context),
              userRepo: RepositoryProvider.of<UserRepo>(context),
            ),
        child: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushAndRemoveUntil(context, Routes.home(), (route) => false);
              } else if (state is LoginFailure) {
                toastification.show(
                  context: context,
                  type: ToastificationType.error,
                  autoCloseDuration: const Duration(seconds: 5),
                  description: Text(state.message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  alignment: Alignment.topCenter,
                  style: ToastificationStyle.fillColored,
                  showProgressBar: false,
                );
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      children: [
                        Image.asset('assets/images/logo/logo-color-with-name.png'),
                        const SizedBox(height: 50),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: LoginForm(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
