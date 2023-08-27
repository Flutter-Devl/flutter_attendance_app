import 'package:flutter/foundation.dart';

class CheckInOutRecord {
  final DateTime checkInTime;
  final DateTime checkOutTime;

  CheckInOutRecord({required this.checkInTime, required this.checkOutTime});
}

class CheckInOutHistoryProvider with ChangeNotifier {
  List<CheckInOutRecord> checkInOutHistory = [];

  void addRecord(CheckInOutRecord record) {
    checkInOutHistory.add(record);
    notifyListeners();
  }
}
