import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/domain/repository/user/user_repo.dart';
import 'package:booko/presentation/bloc/ticket/ticket_cubit.dart';
import 'package:booko/presentation/widget/shared/content_unavailable.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer_pro/shimmer_pro.dart';

class TicketsListPage extends StatelessWidget {
  const TicketsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ticketCubit = TicketCubit(userRepo: RepositoryProvider.of<UserRepo>(context))..onFetchTickets();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
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
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: BlocBuilder<TicketCubit, TicketState>(
              bloc: ticketCubit,
              builder: (context, state) {
                if (state is TicketLoading) {
                  return ListView.separated(
                    itemCount: 3,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return ShimmerPro.sized(
                        height: 140,
                        width: null,
                        scaffoldBackgroundColor: ThemeColor.surface,
                      );
                    },
                  );
                } else if (ticketCubit.userRepo.tickets.isEmpty) {
                  return const Center(
                    child: ContentUnavailable(
                      message: "You haven't bought any tickets yet.",
                      imagePath: "assets/images/content/buy-ticket.png",
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: ticketCubit.userRepo.tickets.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final ticket = ticketCubit.userRepo.tickets.elementAt(index);

                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: QrImageView(
                                data: ticket.ticketNumber!,
                                version: QrVersions.auto,
                                size: 100.0,
                              ),
                            ),
                            const Dash(
                              direction: Axis.vertical,
                              length: 130,
                              dashThickness: 6,
                              dashGap: 10,
                              dashLength: 13,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      ticket.movieTitle!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 5),
                                    Text("Date: ${DateFormat.yMMMMd().format(ticket.schedule!)}"),
                                    Text("Time: ${TimeOfDay.fromDateTime(ticket.schedule!).format(context)}"),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                        if (index == ticketCubit.userRepo.tickets.length - 1) const SizedBox(height: 20)
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
