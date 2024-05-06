part of 'package:booko/presentation/pages/user/seat_page.dart';

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
