import 'package:flutter/material.dart';
import 'package:f1_wiki/models/driver.dart';
import 'package:f1_wiki/widgets/driver/driver_detail.dart';

class DriverItem extends StatelessWidget {
  final Driver driver;

  const DriverItem({
    Key? key,
    required this.driver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _goTo(context, Card_Driver.routeName, argument: driver);
      },
      leading: Icon(Icons.person),
      title: Text("${driver.firstname} ${driver.lastname}"),
    );
  }

  void _goTo(BuildContext context, String name, {dynamic argument}) {
    Navigator.of(context).pushNamed(name, arguments: argument);
  }
}
