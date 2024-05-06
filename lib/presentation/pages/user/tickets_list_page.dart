import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketsListPage extends StatelessWidget {
  const TicketsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepo = RepositoryProvider.of<UserRepo>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: ThemeColor.surfaceVariant, width: 2),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, color: ThemeColor.surfaceVariant),
              ),
            ),
            actions: const [
              Text("My Tickets",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
