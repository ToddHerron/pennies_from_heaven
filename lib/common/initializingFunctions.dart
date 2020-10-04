import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'appConfig.dart';

void startProduction() {
  AppConfig.getInstance(
    appName: 'PRODUCTION',
    flavorName: 'production',
    apiBaseUrl: 'https://myservice.production/api/v1',
  );
}

void startDevelopment() {
  AppConfig.getInstance(
    appName: 'DEVELOPMENT',
    flavorName: 'development',
    apiBaseUrl: 'https://myservice.production/api/v1',
  );
}

void getFlavor() {
  WidgetsFlutterBinding.ensureInitialized();
  const MethodChannel('flavor')
      .invokeMethod<String>('getFlavor')
      .then((String flavor) {
    print('STARTED WITH FLAVOR $flavor');
    if (flavor == 'production') {
      startProduction();
    } else if (flavor == 'development') {
      startDevelopment();
    }
// add other environments here
  }).catchError((error) {
    print(error);
    print('FAILED TO LOAD FLAVOR');
  });
}
