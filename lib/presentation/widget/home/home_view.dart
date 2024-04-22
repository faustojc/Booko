import 'package:booko/presentation/bloc/home/movies_bloc.dart';
import 'package:booko/presentation/widget/home/movies_grid.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeView extends HookWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return () => context.read<MoviesBloc>().add(MoviesFetchInitialData());
    }, const []);

    return RefreshIndicator(
      onRefresh: () async {
        context.read<MoviesBloc>().add(MoviesFetchLatestData());
        await context.read<MoviesBloc>().stream.firstWhere((state) => state is! MoviesLoading);
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Now Showing",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(color: ThemeColor.primary, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const MoviesGrid(isNowShowing: true),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Upcoming Movies",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(color: ThemeColor.primary, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const MoviesGrid(isNowShowing: false),
          ],
        ),
      ),
    );
  }
}
