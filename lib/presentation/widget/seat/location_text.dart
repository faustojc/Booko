import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationText extends StatelessWidget {
  const LocationText({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = RepositoryProvider.of<MovieRepo>(context).currentMovie;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          const Icon(
            Icons.location_on,
            color: ThemeColor.surfaceVariant,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  movie.cinemaName!,
                  maxLines: 2,
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AutoSizeText(movie.location!,
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(
                      color: ThemeColor.surfaceVariant,
                      fontSize: 14,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
