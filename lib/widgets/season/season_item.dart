import 'package:flutter/material.dart';
import 'package:f1_wiki/screens/driver_screen.dart';

class SeasonItem extends StatelessWidget {
  final int date;

  const SeasonItem({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.red,
        child: InkWell(
          splashColor: Colors.red.withAlpha(30),
          onTap: () {
            _goTo(context, DriverScreen.routeName, argument: date);
          },
          child: SizedBox(
            width: 300,
            height: 100,
            child: Center(
              child: Text(
                "SAISON ${date}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _goTo(BuildContext context, String name, {dynamic argument}) {
  Navigator.of(context).pushNamed(name, arguments: argument);
}
