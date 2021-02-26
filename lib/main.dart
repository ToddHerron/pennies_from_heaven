import 'package:pennies_from_heaven/app/auth_widget.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/app/auth_widget_builder.dart';
import 'package:pennies_from_heaven/services/firebase_auth_service.dart';
import 'package:pennies_from_heaven/services/image_picker_service.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import 'common/initializingFunctions.dart';
import 'models/build_flavor.dart';

final getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<BuildFlavor>(BuildFlavor());
  // getIt.registerSingleton<BuildFlavor>(BuildFlavor());
  getFlavor();
  await Firebase.initializeApp();
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
        ChangeNotifierProvider<ValueNotifier<bool>>(
            create: (_) => ValueNotifier<bool>(false)) // avatarLoading toggle
      ],
      child: StreamBuilder<Object>(
          stream: getIt<BuildFlavor>().stream$,
          builder: (context, snapshot) {
            return AuthWidgetBuilder(builder: (context, userSnapshot) {
              return MaterialApp(
                theme: ThemeData(primarySwatch: Colors.indigo),
                home: AuthWidget(
                  userSnapshot: userSnapshot,
                ),
              );
            });
          }),
    );
  }
}
