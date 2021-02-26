import 'package:rxdart/rxdart.dart';

class BuildFlavor {
  // ignore: close_sinks
  BehaviorSubject _buildFlavor = BehaviorSubject.seeded("No Flavor");

  Stream get stream$ => _buildFlavor.stream;

  String get buildFlavor => _buildFlavor.value;

  // add build flavor to the stream
  void setBuildFlavor(String flavor) {
    _buildFlavor.add(flavor);
  }
}
