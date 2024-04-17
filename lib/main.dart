import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:booko/presentation/bloc/app/app_bloc.dart';
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

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepo>(
        create: (_) => AuthRepo(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppBloc>(create: (context) {
              final appBloc = AppBloc(authRepo: RepositoryProvider.of<AuthRepo>(context));

              appBloc.add(AppCheckAuth());
              return appBloc;
            }),
          ],
          child: PopScope(
            canPop: Navigator.canPop(context),
            onPopInvoked: (didPop) async {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                await MoveToBackground.moveTaskToBack();
              }
            },
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Booko',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const StartupPage(),
            ),
          ),
        ));
  }
}
