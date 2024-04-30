import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:booko/presentation/bloc/app/app_bloc.dart';
import 'package:booko/presentation/pages/startup_page.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  String storageLocation = (await getApplicationDocumentsDirectory()).path;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FastCachedImageConfig.init(subDir: storageLocation, clearCacheAfter: const Duration(days: 15));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepo>(create: (_) => AuthRepo()),
          RepositoryProvider<UserRepo>(create: (context) => UserRepo(authRepo: RepositoryProvider.of<AuthRepo>(context))),
          RepositoryProvider<MovieRepo>(create: (_) => MovieRepo()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AppBloc>(create: (context) {
              return AppBloc(authRepo: RepositoryProvider.of<AuthRepo>(context))..add(AppCheckAuth());
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
                colorScheme: ColorScheme.fromSeed(
                  seedColor: ThemeColor.primary,
                  primary: ThemeColor.primary,
                  secondary: ThemeColor.secondary,
                  tertiary: ThemeColor.tertiary,
                  background: ThemeColor.background,
                  surface: ThemeColor.surface,
                  surfaceVariant: ThemeColor.surfaceVariant,
                  outline: ThemeColor.outline,
                ),
                textTheme: const TextTheme(
                  displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  displayMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  displaySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                useMaterial3: true,
              ),
              home: const StartupPage(),
            ),
          ),
        ));
  }
}
