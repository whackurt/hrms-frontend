import 'package:flutter/foundation.dart';

class ZoneProvider extends ChangeNotifier {
  List zoneList = [];

  void setZoneList({required List data}) {
    zoneList = data;
    notifyListeners();
  }
}
