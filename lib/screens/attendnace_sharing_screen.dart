import 'package:flutter/material.dart';
import 'package:flutter_attendance_app/screens/pdf_generator.dart';
import 'package:flutter_attendance_app/service/attendance_provider.dart';
import 'package:provider/provider.dart';

class AttendanceSharingScreen extends StatelessWidget {
  const AttendanceSharingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkInOutHistoryProvider =
        Provider.of<CheckInOutHistoryProvider>(context);
    final history = checkInOutHistoryProvider.checkInOutHistory;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Sharing Screen',
            style: TextStyle(fontSize: 24)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                generatePDF(history);
              },
              child: const Text('Share as PDF'),
            )
          ],
        ),
      ),
    );
  }
}
