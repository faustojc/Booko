import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/domain/repository/seat/seat_repo.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:booko/domain/routes/route.dart';
import 'package:booko/presentation/bloc/seat/seat_cubit.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:shimmer_pro/shimmer_pro.dart';
import 'package:toastification/toastification.dart';

part 'package:booko/presentation/widget/seat/buy_ticket_button.dart';
part 'package:booko/presentation/widget/seat/date_input.dart';
part 'package:booko/presentation/widget/seat/location_text.dart';
part 'package:booko/presentation/widget/seat/quantity_text.dart';
part 'package:booko/presentation/widget/seat/seat_layout.dart';
part 'package:booko/presentation/widget/seat/total_price_text.dart';

class SeatPage extends StatelessWidget {
  const SeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = RepositoryProvider.of<MovieRepo>(context).currentMovie;

    return RepositoryProvider<SeatRepo>(
      create: (context) => SeatRepo(movie: movie),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: BlocProvider<SeatCubit>(
          create: (context) => SeatCubit(
            seatRepo: RepositoryProvider.of<SeatRepo>(context),
            authRepo: RepositoryProvider.of<AuthRepo>(context),
            userRepo: RepositoryProvider.of<UserRepo>(context),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: ThemeColor.surfaceVariant, width: 2),
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, color: ThemeColor.surfaceVariant),
                ),
              ),
              title: AutoSizeText(
                movie.title!,
                maxLines: 2,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
              ),
              centerTitle: true,
            ),
            body: BlocListener<SeatCubit, SeatState>(
              listener: (context, state) async {
                final seatCubit = context.read<SeatCubit>();

                if (state is SeatTicketBought) {
                  Navigator.pop(context);
                  Navigator.push(context, Routes.qrCode(tickets: state.data));
                }

                if (state is SeatError) {
                  toastification.show(
                    context: context,
                    type: ToastificationType.error,
                    autoCloseDuration: const Duration(seconds: 5),
                    alignment: Alignment.topCenter,
                    style: ToastificationStyle.fillColored,
                    showProgressBar: false,
                    title: Text(state.message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
                  );
                }

                if (state is SeatConfirmSelection) {
                  await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                            backgroundColor: Colors.white,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 10),
                                Center(
                                  child: FastCachedImage(
                                    url: seatCubit.seatRepo.movie.posterUrl!,
                                    fit: BoxFit.fitHeight,
                                    loadingBuilder: (context, progressData) {
                                      return ShimmerPro.sized(
                                        light: ShimmerProLight.lighter,
                                        scaffoldBackgroundColor: ThemeColor.surfaceVariant,
                                        height: null,
                                        width: null,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  seatCubit.seatRepo.movie.title!,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 10),
                                Text("Date: ${DateFormat.yMMMMd().format(seatCubit.seatRepo.selectedSchedule!)}"),
                                Text("Time: ${TimeOfDay.fromDateTime(seatCubit.seatRepo.selectedSchedule!).format(context)}"),
                                Text("Quantity: ${seatCubit.seatRepo.quantity}"),
                                Text("Total Price: ₱ ${seatCubit.seatRepo.totalPrice}"),
                                const SizedBox(height: 30),
                                ElevatedButton(
                                    onPressed: () async => await seatCubit.onBuyTicket(),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.black),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                    ),
                                    child: const Text(
                                      "Confirm Payment",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                    ),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ],
                            ),
                          ));
                }
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(child: DateInput()),
                    const SizedBox(height: 30),
                    const LocationText(),
                    const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Icon(Icons.crop_square_rounded, color: ThemeColor.surfaceVariant, size: 40),
                            SizedBox(height: 10),
                            Text('Empty', style: TextStyle(color: ThemeColor.surfaceVariant, fontSize: 12)),
                          ]),
                          Column(children: [
                            Icon(Icons.square_rounded, color: ThemeColor.primary, size: 40),
                            SizedBox(height: 10),
                            Text('Selected', style: TextStyle(color: ThemeColor.primary, fontSize: 12)),
                          ]),
                          Column(children: [
                            Icon(Icons.square_rounded, color: Colors.white, size: 40),
                            SizedBox(height: 10),
                            Text('Occupied', style: TextStyle(color: Colors.white, fontSize: 12)),
                          ]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Image.asset("assets/images/misc/theater-icon.png", fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Press the seat to select it',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ThemeColor.surfaceVariant, fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 30),
                    const SeatLayout(),
                    const SizedBox(height: 30),
                    const QuantityText(),
                    const SizedBox(height: 10),
                    const TotalPriceText(),
                    const SizedBox(height: 30),
                    const BuyTicketButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
