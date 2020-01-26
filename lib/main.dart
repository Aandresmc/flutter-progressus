import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:login_progressus/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.pinkAccent[100],
          brightness: Brightness.light,
          accentColor: Colors.pinkAccent[100]),
      title: 'Progressus',
      initialRoute: '/',
      routes: Routes(context: context).routes(),
    );
  }
}
