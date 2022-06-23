import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:f1_wiki/models/driver.dart';

class F1Services {
  static Future<List<Driver>> getDrivers(id) async {
    final response = await http.get(
      Uri.parse("http://ergast.com/api/f1/$id/drivers.json"),
    );

    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    final List<Driver> drivers = [];
    drivers.addAll((jsonBody["MRData"]["DriverTable"]["Drivers"] as List)
        .map((driver) => Driver.fromJson(driver))
        .toList());
    return drivers;
  }
}
