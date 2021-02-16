import 'package:flutter/services.dart';

import 'appConfig.dart';

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
    print('STARTED WITH FLAVOR $flavor');

    if (flavor == 'prod') {
      startProduction();
    } else if (flavor == 'dev') {
      startDevelopment();
    }
// add other environments here
  }).catchError((error) {
    print(error);
    print('FAILED TO LOAD FLAVOR');
  });
}
