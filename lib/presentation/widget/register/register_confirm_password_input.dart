part of 'package:booko/presentation/widget/register/register_form.dart';

class RegisterConfirmPasswordInput extends HookWidget {
  const RegisterConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    final obscure = useState<bool>(true);

    return BlocBuilder<RegisterCubit, RegisterState>(
      bloc: registerCubit,
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: Colors.white),
          obscureText: obscure.value,
          validator: (password) {
            if (password == null || password.isEmpty) {
              registerCubit.onInputChanged(confirmPassword: password!.trim(), isConfirmPasswordValid: false);
              return 'Password field cannot be empty';
            }

            if (password.length < 6) {
              registerCubit.onInputChanged(confirmPassword: password.trim(), isConfirmPasswordValid: false);
              return 'Password must be at least 6 characters';
            }

            if (state is RegisterInputChanged && password != registerCubit.data.password) {
              context.read<RegisterCubit>().onInputChanged(confirmPassword: password.trim(), isConfirmPasswordValid: false);
              return 'Passwords do not match';
            }

            registerCubit.onInputChanged(confirmPassword: password.trim(), isConfirmPasswordValid: true);
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.key_outlined, color: ThemeColor.surfaceVariant),
            suffixIcon: obscure.value
                ? IconButton(
                    icon: const Icon(Icons.visibility_off, color: ThemeColor.surfaceVariant),
                    onPressed: () => obscure.value = false,
                  )
                : IconButton(
                    icon: const Icon(Icons.visibility, color: ThemeColor.surfaceVariant),
                    onPressed: () => obscure.value = true,
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
