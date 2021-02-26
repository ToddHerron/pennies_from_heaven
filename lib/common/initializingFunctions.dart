import 'package:flutter/services.dart';
import 'package:pennies_from_heaven/models/build_flavor.dart';
import 'appConfig.dart';
import 'package:get_it/get_it.dart';

void startProduction() {
  AppConfig.getInstance(
    appName: 'PRODUCTION',
    flavorName: 'prod',
    apiBaseUrl: 'https://myservice.production/api/v1',
  );
}

void startDevelopment() {
  AppConfig.getInstance(
    appName: 'DEVELOPMENT',
    flavorName: 'dev',
    apiBaseUrl: 'https://myservice.production/api/v1',
  );
}

void getFlavor() {
  const MethodChannel('flavor')
      .invokeMethod<String>('getFlavor')
      .then((String flavor) {
    GetIt.I<BuildFlavor>().setBuildFlavor(flavor);
    print('🟩 🟩 🟩 STARTED WITH FLAVOR ${GetIt.I<BuildFlavor>().buildFlavor}');
    if (flavor == 'prod') {
      startProduction();
    } else if (flavor == 'dev') {
      startDevelopment();
    }
// add other environments here
  }).catchError((error) {
    print(error);
    print('initializingFunctions.dart 🟥 🟥 🟥 FAILED TO LOAD FLAVOR');
  });
}
