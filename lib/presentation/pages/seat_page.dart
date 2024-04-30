import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/domain/repository/seat/seat_repo.dart';
import 'package:booko/presentation/bloc/seat/seat_cubit.dart';
import 'package:booko/presentation/widget/seat/buy_ticket_button.dart';
import 'package:booko/presentation/widget/seat/date_input.dart';
import 'package:booko/presentation/widget/seat/location_text.dart';
import 'package:booko/presentation/widget/seat/quantity_text.dart';
import 'package:booko/presentation/widget/seat/seat_layout.dart';
import 'package:booko/presentation/widget/seat/total_price_text.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          create: (context) => SeatCubit(RepositoryProvider.of<SeatRepo>(context)),
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
            body: SingleChildScrollView(
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
                    child: Image.asset(
                      "assets/images/misc/theater-icon.png",
                      fit: BoxFit.contain,
                    ),
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
    );
  }
}
