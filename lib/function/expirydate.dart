import 'package:flutter/material.dart';

DateTime expiryDateValue({required String timestamp}) {
  DateTime twentyEightDaysFromNow =
      timeConverted(timestamp: '1664620531634').add(const Duration(days: 28));
  debugPrint("fiftyDaysFromNow $twentyEightDaysFromNow");
  return twentyEightDaysFromNow;
}

DateTime timeConverted({required timestamp}) {
  int pageCount = int.parse(timestamp ?? '12356845');
  DateTime date = DateTime.fromMillisecondsSinceEpoch(pageCount);
  debugPrint("date :: $date");
  return date;
}
