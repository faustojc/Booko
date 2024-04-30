import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/presentation/bloc/seat/seat_cubit.dart';
import 'package:booko/presentation/widget/seat/date_input.dart';
import 'package:booko/presentation/widget/seat/location_text.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SeatPage extends HookWidget {
  const SeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = RepositoryProvider.of<MovieRepo>(context).currentMovie;
    final quantity = useState<int>(0);

    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: BlocProvider<SeatCubit>(
        create: (context) => SeatCubit(),
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
            padding: const EdgeInsets.only(top: 40),
            child: Column(
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
                Image.asset(
                  "assets/images/misc/theater-icon.png",
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30),

                // TODO: Put Seat layout here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
