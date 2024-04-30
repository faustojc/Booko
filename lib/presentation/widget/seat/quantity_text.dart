import 'package:booko/domain/repository/seat/seat_repo.dart';
import 'package:booko/presentation/bloc/seat/seat_cubit.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuantityText extends StatelessWidget {
  const QuantityText({super.key});

  @override
  Widget build(BuildContext context) {
    final seatRepo = RepositoryProvider.of<SeatRepo>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        const Text('Quantity: ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(width: 10),
        BlocBuilder<SeatCubit, SeatState>(
          buildWhen: (previous, current) => current is SeatInputChanged,
          builder: (context, state) {
            return Text(
              seatRepo.quantity.toString(),
              style: const TextStyle(color: ThemeColor.primary, fontSize: 16, fontWeight: FontWeight.w700),
            );
          },
        )
      ]),
    );
  }
}
