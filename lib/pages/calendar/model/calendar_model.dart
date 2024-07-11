import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarModel {
  String todaysDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String dayOfMonth = DateFormat('dd').format(DateTime.now());
  String monthName = DateFormat('MMMM').format(DateTime.now());

  final Map<String, String> digitsMap = {
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  final Map<int, String> banglaWeekDayMap = {
    DateTime.monday: 'সোম',
    DateTime.tuesday: 'মঙ্গল',
    DateTime.wednesday: 'বুধ',
    DateTime.thursday: 'বৃহ:',
    DateTime.friday: 'শুক্র',
    DateTime.saturday: 'শনি',
    DateTime.sunday: 'রবি',
  };

  final Map<String, String> monthMap = {
    'january': 'জানুয়ারী',
    'february': 'ফেব্রুয়ারী',
    'march': 'মার্চ',
    'april': 'এপ্রিল',
    'may': 'মে',
    'june': 'জুন',
    'july': 'জুলাই',
    'august': 'আগস্ট',
    'september': 'সেপ্টেম্বর',
    'october': 'অক্টোবর',
    'november': 'নভেম্বর',
    'december': 'ডিসেম্বর',
  };
}