import 'package:flutter/material.dart';
import 'package:f1_wiki/models/driver.dart';
import 'package:f1_wiki/services/f1_service.dart';
import 'package:f1_wiki/widgets/driver/driver_item.dart';

class DriverList extends StatelessWidget {
  const DriverList({
    Key? key,
    required this.idSeason,
  }) : super(key: key);

  final int idSeason;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: F1Services.getDrivers(idSeason),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }
              if (snapshot.hasData) {
                final List<Driver> drivers = snapshot.data;
                if (drivers.isEmpty) {
                  return Center(
                    child: Text("Empty list"),
                  );
                }
                return ListView.builder(
                  itemCount: drivers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DriverItem(driver: drivers[index]);
                  },
                );
              } else {
                return Center(
                  child: Text("No data"),
                );
              }
            default:
              return Container();
          }
        },
      ),
    );
  }
}
