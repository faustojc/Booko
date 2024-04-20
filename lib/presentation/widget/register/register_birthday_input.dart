import 'package:booko/presentation/bloc/auth/register/register_cubit.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RegisterBirthdayInput extends StatefulWidget {
  const RegisterBirthdayInput({super.key});

  @override
  State<RegisterBirthdayInput> createState() => _RegisterBirthdayInputState();
}

class _RegisterBirthdayInputState extends State<RegisterBirthdayInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          controller: _controller,
          style: const TextStyle(color: Colors.white),
          readOnly: true,
          onTap: () async {
            await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              currentDate: state.birthday ?? DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: ThemeColor.primary,
                      onPrimary: Colors.white,
                      onSurface: Colors.white,
                    ),
                  ),
                  child: child!,
                );
              },
            ).then((date) {
              if (date != null) {
                context.read<RegisterCubit>().onInputChanged(birthday: date);
                _controller.text = DateFormat.yMMMMd().format(date);
              }
            });
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.calendar_month, color: ThemeColor.surfaceVariant),
            hintText: 'Enter your birthday',
            hintStyle: const TextStyle(color: ThemeColor.surfaceVariant),
            errorText: (_controller.text.isEmpty) ? "Please select your birthday" : null,
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
