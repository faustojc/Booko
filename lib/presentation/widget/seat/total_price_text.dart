part of 'package:booko/presentation/pages/seat_page.dart';

class TotalPriceText extends StatelessWidget {
  const TotalPriceText({super.key});

  @override
  Widget build(BuildContext context) {
    final seatRepo = RepositoryProvider.of<SeatRepo>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Text(
            'Total Price: P ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          BlocBuilder<SeatCubit, SeatState>(
              buildWhen: (previous, current) => current is SeatInputChanged,
              builder: (context, state) {
                return Text(
                  seatRepo.totalPrice.toStringAsFixed(2),
                  style: const TextStyle(color: ThemeColor.primary, fontSize: 16, fontWeight: FontWeight.w700),
                );
              }),
        ],
      ),
    );
  }
}
