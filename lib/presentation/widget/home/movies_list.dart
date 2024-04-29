import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/data/model/movie.dart';
import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/domain/routes/route.dart';
import 'package:booko/presentation/bloc/home/movies_bloc.dart';
import 'package:booko/presentation/widget/shared/content_unavailable.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class MovieList extends StatelessWidget {
  final bool isNowShowing;

  const MovieList({super.key, required this.isNowShowing});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is MoviesLoading && state.isFirstFetch) {
          return GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 360,
            ),
            children: List.generate(
              2,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ShimmerPro.sized(
                    light: ShimmerProLight.darker,
                    scaffoldBackgroundColor: ThemeColor.surface,
                    height: 250,
                    width: double.infinity,
                  ),
                  ShimmerPro.text(
                    light: ShimmerProLight.darker,
                    scaffoldBackgroundColor: ThemeColor.surface,
                    alignment: Alignment.centerLeft,
                    maxLine: 3,
                  ),
                ],
              ),
            ),
          );
        }

        late List<Movie> movies = state.movies;

        if (movies.isNotEmpty) {
          movies = state.movies.where((movie) {
            if (isNowShowing) {
              return movie.schedules.every((schedule) => schedule.month == DateTime.now().month);
            } else {
              return movie.schedules.every((schedule) => schedule.month > DateTime.now().month && schedule.day > DateTime.now().day);
            }
          }).toList();
        }

        return (movies.isEmpty)
            ? ContentUnavailable(message: (isNowShowing) ? "No current movies" : "No upcoming movies")
            : GridView.builder(
                itemCount: state.movies.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 350,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          RepositoryProvider.of<MovieRepo>(context).currentMovie = movies[index];
                          Navigator.push(context, Routes.movie());
                        },
                        child: SizedBox(
                          height: 260,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: FastCachedImage(
                              url: movies[index].posterUrl!,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, progressData) {
                                return ShimmerPro.sized(
                                  light: ShimmerProLight.darker,
                                  scaffoldBackgroundColor: ThemeColor.surface,
                                  height: 280,
                                  width: double.infinity,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        flex: 0,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AutoSizeText(
                              movies[index].title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              movies[index].genres.join(' / '),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12, color: ThemeColor.surfaceVariant),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
      },
    );
  }
}
