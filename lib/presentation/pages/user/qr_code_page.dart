import 'package:auto_size_text/auto_size_text.dart';
import 'package:booko/domain/repository/home/movie_repo.dart';
import 'package:booko/presentation/widget/qr_code/horizontal_dash_line.dart';
import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatelessWidget {
  final List<String> data;

  const QrCodePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final movie = RepositoryProvider.of<MovieRepo>(context).currentMovie;

    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
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
            },
            backgroundColor: ThemeColor.primary,
            label: const Text('Save to phone', style: TextStyle(color: Colors.white)),
            icon: const Icon(Icons.save_alt, color: Colors.white),
          ),
          body: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.separated(
                itemCount: data.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final seats = data[index].split('/');

                  final Map<String, dynamic> seatData = {
                    'movie_title': seats[0],
                    'schedule': DateTime.parse(seats[1]),
                    'seat': int.parse(seats[2]),
                    'price': double.parse(seats[3]),
                  };

                  if (index == data.length - 1) {
                    return Column(
                      children: [
                        Card(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: QrImageView(
                                    data: data[index],
                                    version: QrVersions.auto,
                                    size: 200.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const HorizontalDashLine(height: 10),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      movie.title!,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("Date: ${DateFormat.yMMMMd().format(seatData['schedule'])}"),
                                    Text("Time: ${TimeOfDay.fromDateTime(seatData['schedule']).format(context)}"),
                                    Text("Seat number: ${seatData['seat']}"),
                                    Text("Price: Php ${seatData['price']}"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 90),
                      ],
                    );
                  }

                  return Card(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: QrImageView(
                              data: data[index],
                              version: QrVersions.auto,
                              size: 200.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const HorizontalDashLine(height: 10),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                movie.title!,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 10),
                              Text("Date: ${DateFormat.yMMMMd().format(seatData['schedule'])}"),
                              Text("Time: ${TimeOfDay.fromDateTime(seatData['schedule']).format(context)}"),
                              Text("Seat number: ${seatData['seat']}"),
                              Text("Price: ₱ ${seatData['price']}"),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
