import 'package:pennies_from_heaven/app/auth_widget.dart';

import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

import 'common/initializingFunctions.dart';

void main() {
  getFlavor();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<FirebaseAuthService>(
      create: (_) => FirebaseAuthService(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: AuthWidget(),
      ),
    );
  }
}
