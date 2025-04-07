import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDate(dynamic timestamp) {
  try {
    DateTime dateTime;

    if (timestamp is Timestamp) {
      dateTime = timestamp.toDate();
    } else if (timestamp is DateTime) {
      dateTime = timestamp;
    } else if (timestamp is String) {
      dateTime = DateTime.tryParse(timestamp) ?? DateTime.now(); // 문자열을 DateTime으로 변환
    } else {
      return 'Invalid Date';
    }
    if(dateTime.year == 1990){
      return '-';
    }

    DateFormat dateFormat = DateFormat('yyyy-MM-dd', 'ko_KR');
    return dateFormat.format(dateTime);
  } catch (e) {
    print(e);
    return 'Invalid Date';
  }
}

String formatPhoneNumber(String input) {
  final RegExp regex = RegExp(r'(\d{3})(\d{4})(\d{4})');
  return input.replaceAllMapped(regex, (Match m) => '${m[1]}-${m[2]}-${m[3]}');
}

String formatNumber(int number) {
  final formatter = NumberFormat('#,###');
  return '${formatter.format(number)} 원';
}
String formatPoint(int number) {
  final formatter = NumberFormat('#,###');
  return '${formatter.format(number)} P';
}