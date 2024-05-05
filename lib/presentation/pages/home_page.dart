import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:booko/domain/routes/route.dart';
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
    final name = userRepo.customer.firstname?.split(' ').first;
    final initials = name!.substring(0, 1).toUpperCase() + userRepo.customer.lastname!.substring(0, 1).toUpperCase();

    return BlocProvider<MoviesBloc>(
      create: (_) => MoviesBloc(RepositoryProvider.of<MovieRepo>(context)),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: BlocListener<MoviesBloc, MoviesState>(
            listener: (context, state) {
              if (state is MoviesError) {
                toastification.show(
                  context: context,
                  type: ToastificationType.error,
                  autoCloseDuration: const Duration(seconds: 5),
                  description: Text(state.message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
                  alignment: Alignment.bottomCenter,
                  style: ToastificationStyle.fillColored,
                  showProgressBar: false,
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset("assets/images/logo/logo-color.png"),
                ),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                        onTap: () => Navigator.push(context, Routes.settings()),
                        child: CircleAvatar(
                          backgroundColor: ThemeColor.primary,
                          child: Text(initials, style: const TextStyle(color: ThemeColor.white)),
                        )),
                  ),
                ],
              ),
              body: const HomeView(),
            ),
          ),
        ),
      ),
    );
  }
}
