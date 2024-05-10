import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/data/model/movie.dart';
import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/domain/routes/route.dart';
import 'package:booko/presentation/bloc/movie/movies_bloc.dart';
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
      builder: (context, state) {
        if (state is MoviesLoading && state.isFirstFetch) {
          return SizedBox(
            height: 350,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              children: List.generate(
                2,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShimmerPro.sized(
                      light: ShimmerProLight.darker,
                      scaffoldBackgroundColor: ThemeColor.surface,
                      height: 240,
                      width: MediaQuery.of(context).size.width * 0.39,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.44,
                      ),
                      child: ShimmerPro.text(
                        light: ShimmerProLight.darker,
                        scaffoldBackgroundColor: ThemeColor.surface,
                        alignment: Alignment.centerLeft,
                        maxLine: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        late Set<Movie> movies = RepositoryProvider.of<MovieRepo>(context).movies;

        if (movies.isNotEmpty) {
          movies = movies.where((movie) {
            if (isNowShowing) {
              return movie.schedules.every((schedule) => schedule.month == DateTime.now().month);
            } else {
              return movie.schedules.every((schedule) => schedule.month > DateTime.now().month && schedule.day > DateTime.now().day);
            }
          }).toSet();
        }

        return (movies.isEmpty)
            ? ContentUnavailable(
                message: (isNowShowing) ? "No current movies" : "No upcoming movies",
                imagePath: "assets/images/content/no-movies.png",
              )
            : SizedBox(
                height: 350,
                child: ListView.separated(
                  itemCount: movies.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(width: 15),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            RepositoryProvider.of<MovieRepo>(context).currentMovie = movies.elementAt(index);
                            Navigator.push(context, Routes.movie());
                          },
                          child: SizedBox(
                            height: 260,
                            width: MediaQuery.of(context).size.width * 0.40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: FastCachedImage(
                                url: movies.elementAt(index).posterUrl!,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, progressData) {
                                  return ShimmerPro.sized(
                                    light: ShimmerProLight.darker,
                                    scaffoldBackgroundColor: ThemeColor.surface,
                                    height: 280,
                                    width: null,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.40,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                movies.elementAt(index).title!,
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
                                movies.elementAt(index).genres.join(' / '),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12, color: ThemeColor.surfaceVariant),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
      },
    );
  }
}
