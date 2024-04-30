import 'package:booko/presentation/pages/home_page.dart';
import 'package:booko/presentation/pages/login_page.dart';
import 'package:booko/presentation/pages/movie_page.dart';
import 'package:booko/presentation/pages/register_page.dart';
import 'package:booko/presentation/pages/seat_page.dart';
import 'package:flutter/material.dart';

class Routes {
  // Register routes for each page here

  static MaterialPageRoute home() => MaterialPageRoute(builder: (_) => const HomePage());

  static MaterialPageRoute movie() => MaterialPageRoute(builder: (_) => const MoviePage());

  static MaterialPageRoute login() => MaterialPageRoute(builder: (_) => const LoginPage());

  static MaterialPageRoute register() => MaterialPageRoute(builder: (_) => const RegisterPage());

  static MaterialPageRoute seat() => MaterialPageRoute(builder: (_) => const SeatPage());
}
