import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

import '../../bloc/seat/seat_plan_bloc.dart';

class DateInput extends HookWidget {
  const DateInput({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = RepositoryProvider.of<MovieRepo>(context).currentMovie;
    final controller = useTextEditingController(text: 'Select date');

    return BlocBuilder<SeatPlanBloc, SeatPlanState>(builder: (context, state) {
      return DropdownMenu<DateTime>(
        controller: controller,
        hintText: "Select time",
        leadingIcon:
            const Icon(Icons.access_time, color: ThemeColor.surfaceVariant),
        trailingIcon:
            const Icon(Icons.arrow_drop_down, color: ThemeColor.surfaceVariant),
        selectedTrailingIcon:
            const Icon(Icons.arrow_drop_up, color: ThemeColor.surfaceVariant),
        enabled: true,
        enableSearch: false,
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14))),
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
          context.read<SeatPlanBloc>().add(SeatPlanSetDate(date: value));
        },
        textStyle: const TextStyle(color: Colors.white),
        menuStyle: const MenuStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white),
        ),
      );
    });
  }
}
