import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/presentation/widget/seat/date_input.dart';
import 'package:booko/presentation/widget/seat/location_text.dart';
import 'package:booko/presentation/widget/seat/seat_buttons_layout.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../bloc/seat/seat_plan_bloc.dart';

class SeatPage extends HookWidget {
  const SeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = RepositoryProvider.of<MovieRepo>(context).currentMovie;
    final quantity = useState<int>(0);
    final totalPrice = useState<double>(0.0);
    final loading = useState<bool>(false);

    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: BlocProvider<SeatPlanBloc>(
        create: (context) => SeatPlanBloc(),
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
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: ThemeColor.surfaceVariant),
              ),
            ),
            title: AutoSizeText(
              movie.title!,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Center(child: DateInput()),
                SizedBox(height: 30),
                LocationText(),
                SizedBox(height: 30),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.crop_square_outlined,
                              size: 50,
                              color: Colors.white,
                            ),
                            Text(
                              "Empty",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.square_rounded,
                                size: 50,
                                color: Theme.of(context).colorScheme.primary),
                            Text(
                              "Selected Seats",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.square_rounded,
                                size: 50, color: Colors.white),
                            Text(
                              "Occupied",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Icon(
                  Icons.rectangle_rounded,
                  color: Colors.orange,
                  size: 50,
                ),
                const SizedBox(height: 20),
                const SeatButtons()
                // TODO: Put Seat layout here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
