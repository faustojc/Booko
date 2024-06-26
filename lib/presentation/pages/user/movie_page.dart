import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/domain/routes/route.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = RepositoryProvider.of<MovieRepo>(context).currentMovie;

    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: ThemeColor.surfaceVariant),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 400,
                    child: FastCachedImage(
                      url: movie.posterUrl!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AutoSizeText(
                          movie.title!,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          movie.genres.join(' / '),
                          style: const TextStyle(color: ThemeColor.surfaceVariant, fontSize: 14),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "About the movie",
                          style: TextStyle(color: ThemeColor.primary, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        ReadMoreText(
                          movie.description!,
                          trimMode: TrimMode.Line,
                          trimLines: 5,
                          colorClickableText: ThemeColor.secondary,
                          style: const TextStyle(color: ThemeColor.surfaceVariant, fontSize: 13),
                          lessStyle: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                          moreStyle: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 20),
                        if (movie.schedules.every((schedule) => schedule.month == DateTime.now().month && schedule.year == DateTime.now().year))
                          ElevatedButton(
                            onPressed: () => Navigator.push(context, Routes.seat()),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(ThemeColor.secondary),
                              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(14)),
                              )),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: AutoSizeText('Select Seats', style: TextStyle(color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
