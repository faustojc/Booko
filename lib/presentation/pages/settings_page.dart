import 'package:booko/data/model/customer.dart';
import 'package:booko/domain/repository/auth/auth_repo.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:booko/domain/routes/route.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepo = RepositoryProvider.of<UserRepo>(context);
    final authRepo = RepositoryProvider.of<AuthRepo>(context);

    final name = userRepo.customer.firstname?.split(' ').first;
    final initials = name!.substring(0, 1).toUpperCase() + userRepo.customer.lastname!.substring(0, 1).toUpperCase();

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
              Text("My Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: ThemeColor.primary,
                    child: Text(initials,
                        style: const TextStyle(
                          color: ThemeColor.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userRepo.customer.firstname!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
                ),
                const SizedBox(height: 30),

                // View tickets
                ListTile(
                  onTap: () => Navigator.push(context, Routes.ticketList()),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  tileColor: Colors.grey.shade900,
                  leading: const Icon(Icons.confirmation_num, color: Colors.white),
                  title: const Text('View Tickets', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, color: ThemeColor.secondary),
                ),
                const SizedBox(height: 30),

                // Email and Password
                ListTile(
                  onTap: () {},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  tileColor: Colors.grey.shade900,
                  leading: const Icon(Icons.person, color: Colors.white),
                  title: const Text('Email and Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, color: ThemeColor.secondary),
                ),
                const SizedBox(height: 30),

                // Logout
                ListTile(
                  onTap: () async {
                    userRepo.customer = Customer();
                    userRepo.tickets.clear();

                    await authRepo.logout().then((value) {
                      Navigator.pushAndRemoveUntil(context, Routes.login(), (route) => false);
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  tileColor: Colors.grey.shade900,
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, color: ThemeColor.secondary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
