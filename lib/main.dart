import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppConfig {
  final String appName;
  final String flavorName;
  final String apiBaseUrl;

  AppConfig({
    this.appName,
    this.flavorName,
    this.apiBaseUrl,
  });

  static AppConfig _instance;

  static AppConfig getInstance({appName, flavorName, apiBaseUrl}) {
    print ("AppConfig .... getInstance() method");

    if (_instance == null) {
      _instance = AppConfig(
          appName: appName, flavorName: flavorName, apiBaseUrl: apiBaseUrl);
      print('APP CONFIGURED FOR: $flavorName');
      return _instance;
    }
    return _instance;
  }
}

void startProduction() {
  print("startProduction() .... Production initialization");
  AppConfig.getInstance(
    appName: 'PRODUCTION',
    flavorName: 'production',
    apiBaseUrl: 'https://myservice.production/api/v1',
  );
  print("startProduction() .... AppConfig.getInstance().appName    = " + AppConfig.getInstance().appName);
  print("startProduction() .... AppConfig.getInstance().flavorName = " + AppConfig.getInstance().flavorName);
  print("startProduction() .... AppConfig.getInstance().apiBaseUrl = " + AppConfig.getInstance().apiBaseUrl);
}

void startDevelopment() {
  print("startDevelopment() .... Development initialization");
  AppConfig.getInstance(
    appName: 'DEVELOPMENT',
    flavorName: 'development',
    apiBaseUrl: 'https://myservice.production/api/v1',
  );
  print("startDevelopment() .... AppConfig.getInstance().appName    = " + AppConfig.getInstance().appName);
  print("startDevelopment() .... AppConfig.getInstance().flavorName = " + AppConfig.getInstance().flavorName);
  print("startDevelopment() .... AppConfig.getInstance().apiBaseUrl = " + AppConfig.getInstance().apiBaseUrl);
}



void main() {
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

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text('Flavor = ${AppConfig.getInstance().flavorName}',
                style: Theme.of(context).textTheme.headline5,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
