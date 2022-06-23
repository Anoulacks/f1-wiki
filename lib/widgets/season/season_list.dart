import 'package:flutter/material.dart';
import 'package:f1_wiki/widgets/season/season_item.dart';

class SeasonList extends StatelessWidget {
  final List<int> _seasons = List.generate(5, (int index) {
    return index + 2018;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: ListView.builder(
            itemCount: _seasons.length,
            itemBuilder: (BuildContext context, int index) {
              return SeasonItem(
                date: _seasons[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
