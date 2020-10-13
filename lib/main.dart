import 'package:pennies_from_heaven/app/auth_widget.dart';

import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/app/auth_widget_builder.dart';
import 'package:pennies_from_heaven/services/firebase_auth_service.dart';
import 'package:pennies_from_heaven/services/image_picker_service.dart';
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
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
        Provider<ImagePickerService>(create: (_) => ImagePickerService()),
      ],
      child: AuthWidgetBuilder(builder: (context, userSnapshot) {
        return MaterialApp(
          theme: ThemeData(primarySwatch: Colors.indigo),
          home: AuthWidget(
            userSnapshot: userSnapshot,
          ),
        );
      }),
    );
  }
}
