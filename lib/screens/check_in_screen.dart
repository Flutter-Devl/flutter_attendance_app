import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_attendance_app/service/attendance_provider.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckInCheckOutScreen extends StatefulWidget {
  const CheckInCheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckInCheckOutScreenState createState() => _CheckInCheckOutScreenState();
}

class _CheckInCheckOutScreenState extends State<CheckInCheckOutScreen> {
  List<CheckInOutRecord> checkInOutHistory = [];

  bool isCheckedIn = false;
  bool isCheckedOut = false;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  bool isCheckingIn = false;
  bool isCheckingOut = false;
  Timer? checkInTimer;

  void startCheckInTimer() {
    checkInTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        checkInTime = DateTime.now();
      });
    });
  }

  void stopCheckInTimer() {
    if (checkInTimer != null) {
      checkInTimer!.cancel();
    }
  }

  void toggleCheckIn() {
    setState(() {
      if (isCheckingIn) {
        stopCheckInTimer();
        isCheckingIn = false;
      } else {
        checkInTime = DateTime.now();
        startCheckInTimer();
        isCheckingIn = true;
        isCheckingOut = false;

        if (isCheckedOut) {
          final checkInOutHistoryProvider =
              Provider.of<CheckInOutHistoryProvider>(context, listen: false);
          checkInOutHistoryProvider.addRecord(CheckInOutRecord(
            checkInTime: checkInTime!,
            checkOutTime: checkOutTime!,
          ));
          isCheckedOut = false;
        }
      }
    });
  }

  void toggleCheckOut() {
    setState(() {
      if (isCheckingOut) {
        checkOutTime = DateTime.now();
        stopCheckInTimer();
        isCheckingOut = false;

        final checkInOutHistoryProvider =
            Provider.of<CheckInOutHistoryProvider>(context, listen: false);
        checkInOutHistoryProvider.addRecord(CheckInOutRecord(
          checkInTime: checkInTime!,
          checkOutTime: checkOutTime!,
        ));
      } else {
        checkOutTime = null;
        isCheckingOut = true;
        isCheckingIn = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check-In/Check-Out Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            GestureDetector(
              onTap: toggleCheckIn,
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  gradient: isCheckedIn ? Gradients.haze : Gradients.tameer,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: isCheckedIn
                          ? Colors.green.withOpacity(0.5)
                          : Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      isCheckedIn
                          ? 'Checked In'
                          : (isCheckingIn ? 'Checking In...' : 'Check In'),
                      style: const TextStyle(color: Colors.white),
                    ),
                    if (checkInTime != null)
                      Text(
                        'Check-In Time: ${DateFormat('HH:mm:ss').format(checkInTime!)}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      )
                    else
                      const Text(
                        'Check-In Time: 0:0:0',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: toggleCheckOut,
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  gradient: isCheckedOut
                      ? Gradients.hersheys
                      : Gradients.backToFuture,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: isCheckedOut
                          ? Colors.red.withOpacity(0.5)
                          : Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time,
                        size: 40, color: Colors.white),
                    Text(
                      isCheckedOut
                          ? 'Checked Out'
                          : (isCheckingOut ? 'Checking Out...' : 'Check Out'),
                      style: const TextStyle(color: Colors.white),
                    ),
                    if (checkOutTime != null)
                      Text(
                        'Check-Out Time: ${DateFormat('HH:mm:ss').format(checkOutTime!)}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      )
                    else
                      const Text(
                        'Check-Out Time: 0:0:0',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
