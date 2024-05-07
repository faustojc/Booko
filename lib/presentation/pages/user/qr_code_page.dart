import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/data/model/ticket.dart';
import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/domain/routes/route.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatelessWidget {
  final Set<Ticket> tickets;

  const QrCodePage({super.key, required this.tickets});

  @override
  Widget build(BuildContext context) {
    final movie = RepositoryProvider.of<MovieRepo>(context).currentMovie;

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: AutoSizeText(
              movie.title!,
              maxLines: 2,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // TODO: add save functionality as image based on the number of tickets
              Navigator.pushAndRemoveUntil(context, Routes.home(), (route) => false);
            },
            backgroundColor: ThemeColor.primary,
            label: const Text('Save to phone', style: TextStyle(color: Colors.white)),
            icon: const Icon(Icons.save_alt, color: Colors.white),
          ),
          body: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.separated(
                itemCount: tickets.length,
                separatorBuilder: (context, index) => const SizedBox(height: 30),
                itemBuilder: (context, index) {
                  final ticket = tickets.elementAt(index);

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: QrImageView(
                                  data: ticket.ticketNumber!,
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Dash(
                              direction: Axis.horizontal,
                              length: 300,
                              dashThickness: 10,
                              dashGap: 16,
                              dashLength: 14,
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  AutoSizeText(
                                    movie.title!,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 10),
                                  Text("Date: ${DateFormat.yMMMMd().format(ticket.schedule!)}"),
                                  Text("Time: ${TimeOfDay.fromDateTime(ticket.schedule!).format(context)}"),
                                  Text("Seat number: ${ticket.seatNumber}"),
                                  Text("Price: ₱ ${ticket.price}"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      if (index == tickets.length - 1) const SizedBox(height: 90),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
