import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:booko/domain/routes/route.dart';
import 'package:booko/presentation/bloc/auth/register/register_cubit.dart';
import 'package:booko/presentation/widget/register/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (_) => RegisterCubit(
        authRepo: RepositoryProvider.of<AuthRepo>(context),
        userRepo: RepositoryProvider.of<UserRepo>(context),
      ),
      child: SafeArea(
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              Navigator.pushAndRemoveUntil(context, Routes.home(), (route) => false);
            } else if (state is RegisterFailed) {
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
          child: const Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 28),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      letterSpacing: 2.5,
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: RegisterForm(),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
