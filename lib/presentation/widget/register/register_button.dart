import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/presentation/bloc/auth/register/register_cubit.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        if (state is RegisterLoading) {
          return ElevatedButton(
              onPressed: () {},
              child: const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: ThemeColor.white),
              ));
        }

        return ElevatedButton(
          onPressed: () async {
            await context.read<RegisterCubit>().register();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ThemeColor.primary),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14)))),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: AutoSizeText('Register', style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        );
      },
    );
  }
}
