import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:f1_wiki/models/driver.dart';
import 'package:f1_wiki/screens/driver_screen.dart';
import 'package:f1_wiki/screens/home_screen.dart';
import 'package:f1_wiki/screens/screen_404.dart';
import 'package:f1_wiki/themes/theme.dart';
import 'package:f1_wiki/widgets/driver/driver_detail.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.deleteBoxFromDisk('drivers_box');
  await Hive.openBox('drivers_box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
              title: 'F1 Wiki ',
              theme: notifier.darkTheme ? dark : light,
              home: HomeScreen(),
              onGenerateRoute: (RouteSettings settings) {
                final dynamic arguments = settings.arguments;
                switch (settings.name) {
                  case Card_Driver.routeName:
                    Driver? identifier;
                    if (arguments is Driver) {
                      identifier = arguments;
                    }
                    return MaterialPageRoute(
                      builder: (BuildContext context) => Card_Driver(
                        driver: identifier ??
                            Driver("NULL", "NULL", "NULL", "NULL", "NULL",
                                "NULL", "NULL"),
                      ),
                    );
                  case DriverScreen.routeName:
                    int? identifier;
                    if (arguments is int) {
                      identifier = arguments;
                    }
                    return MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DriverScreen(idSeason: identifier ?? 0),
                    );
                  default:
                    return MaterialPageRoute(
                        builder: (BuildContext context) => Screen404());
                }
              });
        }));
  }
}
