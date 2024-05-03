part of 'package:booko/presentation/widget/register/register_form.dart';

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
    final registerCubit = context.read<RegisterCubit>();

    return BlocBuilder<RegisterCubit, RegisterState>(
      bloc: registerCubit,
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
              initialDate: (state is RegisterInputChanged) ? registerCubit.data.birthday ?? DateTime.now() : DateTime.now(),
              currentDate: (state is RegisterInputChanged) ? registerCubit.data.birthday ?? DateTime.now() : DateTime.now(),
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
          validator: (value) => (value!.isEmpty) ? "Please select your birthday" : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.calendar_month, color: ThemeColor.surfaceVariant),
            hintText: 'Enter your birthday',
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
