
import 'package:flutter_task/pages/dashboard/model/dashboard_model.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

  DashboardModel model = DashboardModel();


  int getTotalDuration() {
    int totalDuration = model.endDate.difference(model.startDate).inDays;
    return totalDuration;
  }

  int getDaysPassed() {
    int daysPassed = model.today.difference(model.startDate).inDays;
    return daysPassed;
  }

  double getProgressPercentage() {
    int daysPassed = getDaysPassed();
    int totalDuration = getTotalDuration();
    double progress = daysPassed / totalDuration;
    return progress;
  }


  List getMonthAndDaysPassed() {

    int daysPassed = getDaysPassed();

    int monthsPassed = ((daysPassed / 30).floor());
    int remainingDays = daysPassed % 30;

    String banglaMonths = model.convertToBangla(monthsPassed.toString());
    String banglaDays = model.convertToBangla(remainingDays.toString());

    return [banglaMonths, banglaDays];
  }

  List<String> getRemainingYearsMonthsDays() {

    int yearsPassed = model.today.year - model.startDate.year;
    int monthsPassed = model.today.month - model.startDate.month;
    int daysPassed = model.today.day - model.startDate.day;

    if (daysPassed < 0) {
      monthsPassed--;
      daysPassed += DateTime(model.startDate.year, model.startDate.month + monthsPassed + 1, 0).day;
    }
    if (monthsPassed < 0) {
      yearsPassed--;
      monthsPassed += 12;
    }

    String banglaYears = model.convertToBangla(yearsPassed.toString());
    String banglaMonths = model.convertToBangla(monthsPassed.toString());
    String banglaDays = model.convertToBangla(daysPassed.toString());

    return [
      banglaYears.toString().padLeft(2, '০'),
      banglaMonths.toString().padLeft(2, '০'),
      banglaDays.toString().padLeft(2, '০'),
    ];
  }



}