import 'package:booko/presentation/bloc/movie/movies_bloc.dart';
import 'package:booko/presentation/widget/home/movies_list.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Future<void> movieState = context.read<MoviesBloc>().stream.firstWhere((state) => state is MoviesLoaded || state is MoviesError);

        context.read<MoviesBloc>().add(MoviesFetchLatestData());

        return await movieState;
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Hero(
                    tag: "movies_search_bar",
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Search movies",
                        hintStyle: const TextStyle(color: ThemeColor.surfaceVariant),
                        prefixIcon: const Icon(Icons.search, color: ThemeColor.surfaceVariant),
                        filled: true,
                        fillColor: ThemeColor.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Now Showing",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  const MovieList(isNowShowing: true),
                  const SizedBox(height: 25),
                  const Text(
                    "Upcoming Movies",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  const MovieList(isNowShowing: false),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
