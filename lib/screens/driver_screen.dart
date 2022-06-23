import 'package:flutter/material.dart';
import 'package:f1_wiki/widgets/driver/driver_list.dart';

class DriverScreen extends StatelessWidget {
  static const String routeName = "DriverScreen";

  const DriverScreen({
    Key? key,
    required this.idSeason,
  }) : super(key: key);

  final int idSeason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilotes de la Saison ${idSeason}"),
      ),
      body: DriverList(
        idSeason: idSeason,
      ),
    );
  }
}
