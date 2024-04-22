import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/presentation/bloc/home/movies_bloc.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class HomeView extends HookWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesBloc = BlocProvider.of<MoviesBloc>(context);

    return SingleChildScrollView(
      child: BlocBuilder<MoviesBloc, MoviesState>(
        bloc: moviesBloc,
        builder: (context, state) {
          if (state is MoviesLoading) {
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  2,
                  (index) => ShimmerPro.generated(
                        key: ValueKey(index),
                        scaffoldBackgroundColor: ThemeColor.surface,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ShimmerPro.sized(
                              scaffoldBackgroundColor: ThemeColor.surfaceVariant,
                              height: 200,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 10),
                            ShimmerPro.text(
                              scaffoldBackgroundColor: ThemeColor.surfaceVariant,
                              maxLine: 2,
                            )
                          ],
                        ),
                      )),
            );
          } else if (state is MoviesLoaded) {
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              children: state.movies.map((movie) {
                return Card(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: FastCachedImage(url: movie.posterUrl!, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 10),
                      AutoSizeText(
                        movie.title!,
                        maxLines: 2,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        movie.genres.join(' / '),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: ThemeColor.surfaceVariant),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
