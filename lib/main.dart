import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:booko/presentation/bloc/app/app_bloc.dart';
import 'package:booko/presentation/bloc/startup/startup_bloc.dart';
import 'package:booko/presentation/pages/startup/startup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:move_to_background/move_to_background.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authRepo = AuthRepo();

  runApp(App(authRepo: authRepo));
}

class App extends StatelessWidget {
  final AuthRepo authRepo;

  const App({super.key, required this.authRepo});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authRepo,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppBloc>(create: (context) => AppBloc(authRepo: authRepo)),
            BlocProvider<StartupBloc>(create: (context) => StartupBloc(appBloc: context.read<AppBloc>())),
          ],
          child: const AppView(),
        ));
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Navigator.canPop(context),
      onPopInvoked: (didPop) async {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          await MoveToBackground.moveTaskToBack();
        }
      },
      child: MaterialApp(
        title: 'Booko',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const StartupPage(),
      ),
    );
  }
}
