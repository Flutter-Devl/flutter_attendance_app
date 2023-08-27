import 'dart:io';
import 'package:flutter_attendance_app/service/attendance_provider.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> generatePDF(List<CheckInOutRecord> records) async {
  final pdf = pw.Document();

  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return pw.Center(
        child: pw.Column(
          children: records.map((record) {
            return pw.Row(
              children: [
                pw.Text('Check-In Time: ${DateFormat('HH:mm:ss').format(record.checkInTime)}'),
                pw.Text('Check-Out Time: ${DateFormat('HH:mm:ss').format(record.checkOutTime)}'),
              ],
            );
          }).toList(),
        ),
      );
    },
  ));

  final dir = await getApplicationDocumentsDirectory();
  final path = '${dir.path}/attendance_record.pdf';

  final file = File(path);
  await file.writeAsBytes(await pdf.save());

  await Share.shareFiles([path], text: 'Attendance Record PDF');
}
