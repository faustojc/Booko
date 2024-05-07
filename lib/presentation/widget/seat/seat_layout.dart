part of 'package:booko/presentation/pages/user/seat_page.dart';

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
                  if ((index % 8 == 3 || index % 8 == 4) || (index == 0 || index == 7) || (index / 8 >= 3 && index / 8 < 4)) {
                    return const SizedBox.shrink();
                  } else {
                    final occupied = seatCubit.seatRepo.occupiedSeats.contains(index);
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
