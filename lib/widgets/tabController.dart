import 'package:flutter/material.dart';
import 'package:f1_wiki/screens/favorite_screen.dart';
import 'package:f1_wiki/screens/season_screen.dart';
import 'package:f1_wiki/themes/theme.dart';
import 'package:provider/provider.dart';

class F1TabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("F1 Wiki"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.flag_circle), text: "Saisons"),
              Tab(icon: Icon(Icons.favorite), text: "Favoris"),
              Tab(icon: Icon(Icons.settings), text: "Settings")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SeasonScreen(),
            FavoriteScreen(),
            Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => SwitchListTile(
                title: Text("Dark Mode"),
                onChanged: (val) {
                  notifier.toggleTheme();
                },
                value: notifier.darkTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
