import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:booko/presentation/bloc/home/movies_bloc.dart';
import 'package:booko/presentation/widget/home/home_view.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepo = RepositoryProvider.of<UserRepo>(context);
    final name = userRepo.customer?.firstname?.split(' ').first;
    final initials = name!.substring(0, 2).toUpperCase() + userRepo.customer!.lastname!.substring(0, 2).toUpperCase();

    return BlocProvider<MoviesBloc>(
      create: (_) => MoviesBloc(RepositoryProvider.of<MovieRepo>(context)),
      child: SafeArea(
        child: BlocListener<MoviesBloc, MoviesState>(
          listener: (context, state) {
            if (state is MoviesError) {
              toastification.show(
                context: context,
                type: ToastificationType.error,
                autoCloseDuration: const Duration(seconds: 5),
                description: Text(state.message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
                alignment: Alignment.bottomCenter,
                style: ToastificationStyle.flatColored,
                showProgressBar: false,
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: Image.asset("assets/images/logo/logo-color.png"),
              actions: [
                const Text(
                  "Welcome",
                  style: TextStyle(color: ThemeColor.primary, fontWeight: FontWeight.w500),
                ),
                Text(
                  ", $name",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: ThemeColor.white,
                      child: Text(initials, style: const TextStyle(color: ThemeColor.secondary)),
                    ))
              ],
            ),
            body: const HomeView(),
          ),
        ),
      ),
    );
  }
}
