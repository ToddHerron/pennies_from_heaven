import 'package:pennies_from_heaven/app/sign_in/sign_in_page.dart';

import 'package:flutter/material.dart';

import 'common/appConfig.dart';
import 'common/initializingFunctions.dart';

void main() {
  getFlavor();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.indigo), home: SignInPage());
  }
}
