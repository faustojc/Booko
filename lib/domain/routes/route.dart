import 'package:booko/data/model/ticket.dart';
import 'package:booko/presentation/pages/login_page.dart';
import 'package:booko/presentation/pages/register_page.dart';
import 'package:booko/presentation/pages/user/home_page.dart';
import 'package:booko/presentation/pages/user/movie_page.dart';
import 'package:booko/presentation/pages/user/qr_code_page.dart';
import 'package:booko/presentation/pages/user/seat_page.dart';
import 'package:booko/presentation/pages/user/settings_page.dart';
import 'package:booko/presentation/pages/user/tickets_list_page.dart';
import 'package:flutter/material.dart';

class Routes {
  // Register routes for each page here

  static MaterialPageRoute home() => MaterialPageRoute(builder: (_) => const HomePage());

  static MaterialPageRoute movie() => MaterialPageRoute(builder: (_) => const MoviePage());

  static MaterialPageRoute login() => MaterialPageRoute(builder: (_) => const LoginPage());

  static MaterialPageRoute register() => MaterialPageRoute(builder: (_) => const RegisterPage());

  static MaterialPageRoute seat() => MaterialPageRoute(builder: (_) => const SeatPage());

  static MaterialPageRoute qrCode({required Set<Ticket> tickets}) => MaterialPageRoute(builder: (_) => QrCodePage(tickets: tickets));

  static MaterialPageRoute settings() => MaterialPageRoute(builder: (_) => const SettingsPage());

  static MaterialPageRoute ticketList() => MaterialPageRoute(builder: (_) => const TicketsListPage());
}
