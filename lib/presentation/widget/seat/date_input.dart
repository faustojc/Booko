part of 'package:booko/presentation/pages/user/seat_page.dart';

class DateInput extends HookWidget {
  const DateInput({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = RepositoryProvider.of<MovieRepo>(context).currentMovie;
    final seatCubit = BlocProvider.of<SeatCubit>(context);
    final controller = useTextEditingController(text: 'Select date');

    return DropdownMenu<DateTime>(
      controller: controller,
      hintText: "Select time",
      leadingIcon: const Icon(Icons.access_time, color: ThemeColor.surfaceVariant),
      trailingIcon: const Icon(Icons.arrow_drop_down, color: ThemeColor.surfaceVariant),
      selectedTrailingIcon: const Icon(Icons.arrow_drop_up, color: ThemeColor.surfaceVariant),
      enabled: true,
      enableSearch: false,
      inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          )),
      dropdownMenuEntries: movie.schedules.map((DateTime schedule) {
        return DropdownMenuEntry<DateTime>(
          value: schedule,
          label: DateFormat.yMEd().add_jm().format(schedule),
        );
      }).toList(),
      onSelected: (value) {
        seatCubit.onInputChanged(schedule: value);
      },
      textStyle: const TextStyle(color: Colors.white),
      menuStyle: const MenuStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.white),
      ),
    );
  }
}
