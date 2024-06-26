part of 'package:booko/presentation/widget/register/register_form.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();

    return BlocBuilder<RegisterCubit, RegisterState>(
      bloc: registerCubit,
      buildWhen: (prev, curr) => curr is RegisterLoading || curr is RegisterSuccess || curr is RegisterFailed,
      builder: (context, state) {
        if (state is RegisterLoading) {
          return ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(ThemeColor.primary),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14)))),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircularProgressIndicator(color: ThemeColor.white),
            ),
          );
        } else {
          return ElevatedButton(
            onPressed: () async {
              await registerCubit.register();
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
        }
      },
    );
  }
}
