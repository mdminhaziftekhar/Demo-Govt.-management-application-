import 'package:flutter/material.dart';
import 'package:flutter_task/core/db/entities/data_entity.dart';
import 'package:flutter_task/index.dart';
import 'package:flutter_task/main.dart';
import 'package:get/get.dart';

class CalendarScreen extends StatelessWidget {
   CalendarScreen({super.key});

   final CalendarController calendarController = Get.put(CalendarController());
   final ScrollController scrollController = ScrollController();
   final AddController addController = Get.put(AddController());

   @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Padding(
            padding: [20,20,0,20].pm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topDateAndButtonWidget(context),
                25.ph,
                _datePickerWidget(context),
                25.ph,
                _todaysDataWidget(),
              ],
            ),
          ),
        );
  }

  Widget _todaysDataWidget() {
    return Obx(()=>
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('আজকের কার্যক্রম', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),),
            20.ph,
            calendarController.loadingData.value?
            const Center(
              child: CircularProgressIndicator(color: Color(0xff86B560),strokeWidth: 3,),
            ) :
            calendarController.dataList.value.isNotEmpty? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: calendarController.dataList.value.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: [0,0,15,0].pm,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 2,child: _timeOfTheDay(calendarController.dataList.value[index].parsedTime, calendarController.dataList.value[index].timeOfDay)),
                      Expanded(flex: 3,child: _dataCardWidget(calendarController.dataList.value[index])),
                    ],
                  ),
                );
              },) : const Center(
              child: Text('কোনো তথ্য নেই', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700, fontSize: 16)),
            ),
          ],
        )
    );
  }

  Widget _dataCardWidget(DataEntity data) {
    return Container(

      decoration: BoxDecoration(
        color: data.category == 'অনুচ্ছেদ' ? Colors.black : data.category == 'বাক্য' ? null : Colors.orangeAccent,
        borderRadius: BorderRadius.circular(20),
        gradient: data.category == 'বাক্য' ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.6, 1),
          colors: [
            Color(0xff86B560),
            Color(0xff336F4A),
          ],
        ) : null,
      ),
      child: Padding(
        padding: [10,0,10,12].pm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.watch_later_outlined, color: Colors.white, size: 14,),
                2.pw,
                Text("${calendarController.convertToBanglaDigits(data.parsedTime)} মি.", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),),
              ],
            ),
            5.ph,
            Padding(
              padding: [0,25,0,0].pm,
              child: Text("${data.name}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),),
            ),

            8.ph,
           Text("${data.category}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),),
            8.ph,
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.white, size: 14,),
                2.pw,
                Text("${data.location}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeOfTheDay (String time, String timeOfTheDay) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(timeOfTheDay, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),),
        Text("${calendarController.convertToBanglaDigits(time)} মি.", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),),
      ],
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


   Widget _topDateAndButtonWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'আজ ${calendarController.getTodaysBanglaDate()} ${calendarController.getBanglaMonthName()}',
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),),
        _addButton(context),
      ],
    );
  }

   Widget _addButton(BuildContext context) {
     return InkWell(
       onTap: (){
         Navigator.pushNamed(context, '/add_new').then((value){
           addController.selectedCategory.value = '';
           addController.pickedDate.value = '';
         });
       },
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
