
import 'package:flutter_task/pages/calendar/model/calendar_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController {

  CalendarModel model = CalendarModel();

  var selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;


  void selectDate(String date) {
    selectedDate.value = date;
  }

  List<String> generateDateList() {
    List<DateTime> dates = [];

    DateTime today = DateTime.now();

    for (int i = 7; i >= 1; i--) {
      dates.add(today.subtract(Duration(days: i)));
    }

    dates .add(today);

    for (int i = 1; i <= 7; i++) {
      dates.add(today.add(Duration(days: i)));
    }

    List<String> formattedDates = [];
    for (var element in dates) {
      formattedDates.add(DateFormat('yyyy-MM-dd').format(element));
    }

    return formattedDates;
  }

  String getTodaysBanglaDate(){
    String banglaDate = '';
    for (int i = 0; i < model.dayOfMonth.length; i++) {
      String digit = model.dayOfMonth[i];
      banglaDate += model.digitsMap[digit] ?? digit;
    }
    return banglaDate;
  }

  String getBanglaMonthName() {
    String englishMonthName = model.monthName.toLowerCase();
    return model.monthMap[englishMonthName] ?? englishMonthName;
  }

  String getBanglaDayOfWeek(String dateString) {
    DateTime date = DateTime.parse(dateString).toLocal();
    int dayOfWeek = date.weekday;

    return model.banglaWeekDayMap[dayOfWeek] ?? '';
  }


  String getBanglaDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    String day = DateFormat('dd').format(date);
    String banglaDate = '';
    for (int i = 0; i < day.length; i++) {
      try {
        banglaDate += model.digitsMap[day[i]]!;
      } catch (e) {}
    }
    return banglaDate;
  }

}