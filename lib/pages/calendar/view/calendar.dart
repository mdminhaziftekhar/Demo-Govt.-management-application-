import 'package:flutter/material.dart';
import 'package:flutter_task/index.dart';
import 'package:flutter_task/main.dart';
import 'package:get/get.dart';

class CalendarScreen extends StatelessWidget {
   CalendarScreen({super.key});

  final CalendarController calendarController = Get.put(CalendarController());
   final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Padding(
            padding: [20,20,0,20].pm,
            child: Column(
              children: [
                _topDateAndButtonWidget(),
                25.ph,
                _datePickerWidget(context),
              ],
            ),
          ),
        );
  }

   Widget _datePickerWidget(BuildContext context) {
     List<String> dates = calendarController.generateDateList();

     int selectedIndex = dates.indexWhere((date) => date == calendarController.selectedDate.value);
     WidgetsBinding.instance!.addPostFrameCallback((_) {
       scrollToDateIndex(selectedIndex);
     });

     return Container(
       height: 100,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10.0),
         color: const Color(0xffFDFDFD),
       ),
       child: ListView.builder(
         controller: scrollController,
         scrollDirection: Axis.horizontal,
         itemCount: dates.length,
         itemBuilder: (context, index) {
           String date = dates[index];

           return Padding(
             padding: [10,0,10,0].pm,
             child: GestureDetector(
               onTap: () {
                 calendarController.selectDate(date);
               },
               child: Obx(() =>
                   Container(
                     width: 40.0,
                     margin: [0,10,0,10].pm,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(50.0),
                       border: Border.all(
                         width: 2,
                         color: calendarController.selectedDate.value==date ? const Color(0xff86B560) : Colors.transparent,
                       ),
                     ),
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           calendarController.getBanglaDayOfWeek(date),
                           style: const TextStyle(fontSize: 14.0, color: Color(0xff6A6A6A), fontWeight: FontWeight.w400),
                         ),
                         4.ph,
                         Text(
                           calendarController.getBanglaDate(date),
                           style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
                         ),
                       ],
                     ),
                   )
               ),
             ),
           );
         },
       ),
     );
   }

   void scrollToDateIndex(int index) {
     if (index >= 0 && index < calendarController.generateDateList().length) {
       scrollController.animateTo(
         index * 40.0,
         duration: const Duration(milliseconds: 500),
         curve: Curves.easeInOut,
       );
     }
   }


   Widget _topDateAndButtonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'আজ ${calendarController.getTodaysBanglaDate()} ${calendarController.getBanglaMonthName()}',
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),),
        _addButton(),
      ],
    );
  }

   Widget _addButton() {
     return InkWell(
       onTap: (){},
       child: Container(
         width: 120,
         height: 35,
         decoration: BoxDecoration(
           gradient: const LinearGradient(
             begin: Alignment.topLeft,
             end: Alignment(0.6, 1),
             colors: [
               Color(0xff86B560),
               Color(0xff336F4A),
             ],
           ),
           borderRadius: BorderRadius.circular(20),
         ),
         child: const Center(
           child: Text(
             'নতুন যোগ করুন',
             style: TextStyle(
               color: Colors.white,
               fontSize: 12,
               fontWeight: FontWeight.w700,
             ),
           ),
         ),
       ),
     );
   }
}
