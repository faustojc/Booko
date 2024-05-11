part of 'package:booko/presentation/pages/user/seat_page.dart';

class TotalPriceText extends StatelessWidget {
  const TotalPriceText({super.key});

  @override
  Widget build(BuildContext context) {
    final seatRepo = RepositoryProvider.of<SeatRepo>(context);

    return BlocBuilder<SeatCubit, SeatState>(
        buildWhen: (previous, current) => current is SeatInputChanged,
        builder: (context, state) {
          return Text(
            'Php ${seatRepo.totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
          );
        });
  }
}
