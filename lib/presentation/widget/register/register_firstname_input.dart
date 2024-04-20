import 'package:booko/presentation/bloc/auth/register/register_cubit.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterFirstnameInput extends StatelessWidget {
  const RegisterFirstnameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              context.read<RegisterCubit>().onInputChanged(firstname: value!.trim());
              return 'Firstname field cannot be empty';
            }

            context.read<RegisterCubit>().onInputChanged(firstname: value.trim());
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person_outline, color: ThemeColor.surfaceVariant),
            hintText: 'Enter your first name',
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
