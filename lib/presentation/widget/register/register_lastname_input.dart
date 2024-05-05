part of 'package:booko/presentation/widget/register/register_form.dart';

class RegisterLastnameInput extends StatelessWidget {
  const RegisterLastnameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              context.read<RegisterCubit>().onInputChanged(lastname: value!.trim());
              return 'Lastname field cannot be empty';
            }

            context.read<RegisterCubit>().onInputChanged(lastname: value.trim());
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person_outline, color: ThemeColor.surfaceVariant),
            hintText: 'Enter your last name',
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
