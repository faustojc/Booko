import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:booko/domain/routes/route.dart';
import 'package:booko/presentation/bloc/app/app_bloc.dart';
import 'package:booko/presentation/bloc/startup/startup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final startupBloc = StartupBloc(
      appBloc: BlocProvider.of<AppBloc>(context),
      userRepo: RepositoryProvider.of<UserRepo>(context),
    );

    _precacheImages(context);

    return BlocListener<StartupBloc, StartupState>(
      bloc: startupBloc,
      listener: (context, state) async {
        if (state is StartupHome) {
          Navigator.of(context).pushAndRemoveUntil<void>(Routes.home(), (route) => false);
        } else if (state is StartupLogin) {
          Navigator.of(context).pushAndRemoveUntil<void>(Routes.login(), (route) => false);
        }

        FlutterNativeSplash.remove();
      },
      child: Container(),
    );
  }

  void _precacheImages(BuildContext context) {
    if (context.mounted) {
      precacheImage(const AssetImage('assets/images/logo/logo-color-with-name.png'), context);
      precacheImage(const AssetImage('assets/images/logo/logo-color.png'), context);
      precacheImage(const AssetImage('assets/images/misc/theater-icon.png'), context);
      precacheImage(const AssetImage('assets/images/content/no-movies.png'), context);
      precacheImage(const AssetImage('assets/images/content/buy-ticket.png'), context);
    }
  }
}
