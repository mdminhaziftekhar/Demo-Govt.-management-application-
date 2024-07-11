
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

    int daysDifference = model.endDate.difference(model.today).inDays;

    int yearsRemaining = daysDifference ~/ 365;
    int remainingDays = daysDifference % 365;

    int monthsRemaining = remainingDays ~/ 30;
    remainingDays %= 30;

    if (daysDifference < 0) {
      yearsRemaining = -yearsRemaining;
      monthsRemaining = -monthsRemaining;
      remainingDays = -remainingDays;
    }


    String banglaYears = model.convertToBangla(yearsRemaining.toString());
    String banglaMonths = model.convertToBangla(monthsRemaining.toString());
    String banglaDays = model.convertToBangla(remainingDays.toString());

    return [
      banglaYears.toString().padLeft(2, '০'),
      banglaMonths.toString().padLeft(2, '০'),
      banglaDays.toString().padLeft(2, '০'),
    ];
  }



}