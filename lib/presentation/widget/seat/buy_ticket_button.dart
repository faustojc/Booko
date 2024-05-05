part of 'package:booko/presentation/pages/seat_page.dart';


class BuyTicketButton extends StatelessWidget {
  const BuyTicketButton({super.key});

  @override
  Widget build(BuildContext context) {
    final seatCubit = context.read<SeatCubit>();

    return BlocBuilder<SeatCubit, SeatState>(
      bloc: seatCubit,
      builder: (context, state) {
        if (state is SeatLoading) {
          return ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(ThemeColor.primary),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                )),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: CircularProgressIndicator(color: ThemeColor.white),
              ));
        } else if (seatCubit.seatRepo.selectedSchedule == null ||
            seatCubit.seatRepo.selectedSeats.isEmpty) {
          return ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  ThemeColor.primary.withOpacity(0.4)),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
              )),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text('Buy Ticket',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.4), fontSize: 20)),
            ),
          );
        }

        return ElevatedButton(
          onPressed: () => seatCubit.onBuyTicket(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ThemeColor.primary),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
            )),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text('Buy Ticket',
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        );
      },
    );
  }
}
