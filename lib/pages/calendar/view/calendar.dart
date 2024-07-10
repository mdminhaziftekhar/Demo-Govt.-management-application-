import 'package:flutter/material.dart';
import 'package:flutter_task/index.dart';
import 'package:get/get.dart';

class CalendarScreen extends StatelessWidget {
   CalendarScreen({super.key});

  final CalendarController calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Center(child:Text("Calendar Widget"));
  }
}
