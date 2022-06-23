import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:f1_wiki/models/driver.dart';
import 'package:url_launcher/url_launcher.dart';

class Card_Driver extends StatefulWidget {
  static const String routeName = "DetailDriver";

  final Driver driver;

  const Card_Driver({Key? key, required this.driver}) : super(key: key);

  @override
  State<Card_Driver> createState() => _Card_DriverState();
}

class _Card_DriverState extends State<Card_Driver> {
  final _driverBox = Hive.box('drivers_box');

  @override
  void initState() {
    super.initState();
  }

  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _driverBox.add(newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détail du pilote"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "${widget.driver.firstname + " " + widget.driver.lastname}",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              height: 400,
              padding: EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        offset: Offset(5.0, 5.0)),
                  ],
                  borderRadius: BorderRadius.circular(35),
                  color: Colors.red,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "CODE Pilote: ${widget.driver.code}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Text("Numéro: ${widget.driver.number}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 20),
                    Text("Nationalité: ${widget.driver.nationality}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 20),
                    Text("Né le: ${widget.driver.dateOfBirth}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: _launchUrl,
                      child: Text("Description pilote",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 74, 13, 13))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _createItem({
            "firstname": widget.driver.firstname,
            "lastname": widget.driver.lastname,
            "code": widget.driver.code,
            "number": widget.driver.number,
            "nationality": widget.driver.nationality,
            "dateOfBirth": widget.driver.dateOfBirth,
            "url_bio": widget.driver.url_bio,
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pilote ajouté aux favoris')));
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }

  void _launchUrl() async {
    if (!await launchUrl(Uri.parse(widget.driver.url_bio)))
      throw 'Could not launch ${widget.driver.url_bio}';
  }
}
