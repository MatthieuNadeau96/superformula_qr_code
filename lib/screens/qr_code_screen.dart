import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:superformula_qr_code/models/seed_model.dart';
import 'package:superformula_qr_code/services/api_service.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  // Initialize api call & countdown stream outside of the build widget
  final Future<SeedModel> _future = ApiService().getSeed();
  static const int _count = 15;
  final _countdown = countdown(_count);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
        centerTitle: true,
      ),
      body: StreamBuilder<dynamic>(
          stream: _countdown,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                if (snapshot.hasData) {
                  var count = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder<SeedModel>(
                        future: _future,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            var seed = snapshot.data!.seed;
                            return Center(
                              child: QrImage(
                                data: seed,
                                size: 250,
                              ),
                            );
                          }
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      Text('$count s'),
                    ],
                  );
                }
                break;
              // TODO Create restart button
              case ConnectionState.done:
                return const Center(
                  child: Text('Times up!'),
                );
              default:
            }

            return Container();
          }),
    );
  }
}

Stream<dynamic> countdown(_count) =>
    Stream.periodic(const Duration(seconds: 1), (e) => _count - e).take(16);
