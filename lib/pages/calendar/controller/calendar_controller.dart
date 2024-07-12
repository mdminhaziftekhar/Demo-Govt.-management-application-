import 'package:flutter_task/core/db/DAL/task_respository.dart';
import 'package:flutter_task/pages/calendar/model/calendar_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/db/entities/data_entity.dart';
import '../../../objectbox.g.dart';

class CalendarController extends GetxController {

  CalendarModel model = CalendarModel();

  var selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;

  var dataList = [].obs;

  RxBool loadingData = false.obs;

  @override
  void onInit() {
    fetchDateFromDB(selectedDate.value, initialLoad: true);
    super.onInit();
  }

  Future<void> fetchDateFromDB(String date, {bool? initialLoad}) async {
    if(initialLoad != null) loadingData.value = true;
    TaskRepository<DataEntity> repository = await TaskRepository.init();
    dataList.value.clear();
    dataList.value = await repository.query(DataEntity_.parsedDate.equals(date)).build().findAsync();
    if(initialLoad != null) loadingData.value = false;
  }


  Future<void> selectDate(String date) async {
    loadingData.value = true;
    selectedDate.value = date;

    await fetchDateFromDB(date);

    loadingData.value = false;
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

  String convertToBanglaDigits(String time) {
    String banglaTime = '';

    for (int i = 0; i < time.length; i++) {
      String char = time[i];
      banglaTime += model.digitsMap[char] ?? char;
    }

    return banglaTime;
  }

}