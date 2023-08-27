import 'package:flutter/material.dart';
import 'package:flutter_attendance_app/service/attendance_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkInOutHistoryProvider =
        Provider.of<CheckInOutHistoryProvider>(context);
    final history = checkInOutHistoryProvider.checkInOutHistory;

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance History')),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final record = history[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                'Check-In Time: ${DateFormat('HH:mm:ss').format(record.checkInTime)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Check-Out Time: ${DateFormat('HH:mm:ss').format(record.checkOutTime)}',
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: const Icon(Icons.lock_clock, color: Colors.blue),
            ),
          );
        },
      ),
    );
  }
}
