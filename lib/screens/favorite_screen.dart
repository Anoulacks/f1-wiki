import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:f1_wiki/models/driver.dart';
import 'package:f1_wiki/widgets/driver/driver_detail.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> _items = [];

  final _driverBox = Hive.box('drivers_box');

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  void _refreshItems() {
    final data = _driverBox.keys.map((key) {
      final value = _driverBox.get(key);
      return {
        "key": key,
        "firstname": value["firstname"],
        "lastname": value['lastname'],
        "code": value["code"],
        "nationality": value['nationality'],
        "number": value["number"],
        "dateOfBirth": value["dateOfBirth"],
        "url_bio": value['url_bio'],
      };
    }).toList();

    setState(() {
      _items = data.reversed.toList();
    });
  }

  void _goTo(BuildContext context, String name, {dynamic argument}) {
    Navigator.of(context).pushNamed(name, arguments: argument);
  }

  Driver _createDriver(item) {
    return Driver(
        item['firstname'],
        item['lastname'],
        item['code'],
        item['nationality'],
        item['number'],
        item['dateOfBirth'],
        item['url_bio']);
  }

  // Delete a single item
  Future<void> _deleteItem(int itemKey) async {
    await _driverBox.delete(itemKey);
    _refreshItems();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Le pilote a été supprimé'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'Pas de pilotes',
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              // the list of items
              itemCount: _items.length,
              itemBuilder: (_, index) {
                final currentItem = _items[index];
                return Card(
                  color: Colors.red,
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      title: Text(currentItem['firstname']),
                      subtitle: Text(currentItem['lastname']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.info),
                            onPressed: () => _goTo(
                                context, Card_Driver.routeName,
                                argument: _createDriver(currentItem)),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteItem(currentItem['key']),
                          ),
                        ],
                      )),
                );
              }),
    );
  }
}
