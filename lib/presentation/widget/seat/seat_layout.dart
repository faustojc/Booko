import 'package:booko/presentation/bloc/seat/seat_cubit.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SeatLayout extends HookWidget {
  const SeatLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final seatCubit = BlocProvider.of<SeatCubit>(context);

    useEffect(() {
      seatCubit.onFetchData();
      return () {};
    }, const []);

    return BlocBuilder<SeatCubit, SeatState>(
      builder: (context, state) {
        return Stack(
          children: [
            SizedBox(
              height: 380,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 64,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  crossAxisSpacing: 6.5,
                  mainAxisSpacing: 6.5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index % 8 == 3 || index % 8 == 4) {
                    //for middle space
                    return const SizedBox();
                  } else if (index == 0 || index == 7) {
                    //for first and last squares of first row
                    return const SizedBox();
                  } else if (index / 8 >= 3 && index / 8 < 4) {
                    //for vertical gap
                    return const SizedBox();
                  } else {
                    final occupied = seatCubit.seatRepo.seats.where((seat) => seat.seatNumber! == index).isNotEmpty;
                    final selected = seatCubit.seatRepo.selectedSeats.contains(index);

                    if (occupied) {
                      return Container(
                          width: 55,
                          decoration: BoxDecoration(
                            color: occupied ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ));
                    }

                    return GestureDetector(
                      onTap: () => seatCubit.onInputChanged(seatNumber: index),
                      child: Container(
                          width: 55,
                          decoration: BoxDecoration(
                            color: selected ? ThemeColor.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: selected ? null : Border.all(color: ThemeColor.surfaceVariant, width: 1.5),
                          )),
                    );
                  }
                },
              ),
            ),
            (state is SeatLoading)
                ? SizedBox(
                    height: 380,
                    child: AbsorbPointer(
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                        child: const Center(child: CircularProgressIndicator(color: Colors.white)),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
