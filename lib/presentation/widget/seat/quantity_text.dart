part of 'package:booko/presentation/pages/seat_page.dart';

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
