import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/index.dart';
import 'package:flutter_task/main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatelessWidget {
   AddNewScreen({super.key});

  final AddController addController = Get.put(AddController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('নতুন যোগ করুন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: [20,20,0,20].pm,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textWidget(),
              20.ph,
              _categoryWidget(context),
              20.ph,
              _dateWidget(context),
              20.ph,
              _locationWidget(context),
              20.ph,
              _descriptionWidget(),
              100.ph,
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _saveButton(context),
    );
  }

   Widget _locationWidget(BuildContext context) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         const Text(
           'স্থান',
           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
         ),
         GestureDetector(
           onTap: () async {
             String? locationName = await _selectLocation();
             if (locationName != null) {
               addController.selectedLocation.value = locationName;
             }
           },
           child: Obx(() => Container(
             height: 50,
             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
             decoration: BoxDecoration(
               color: const Color(0xffF2F2F2),
               borderRadius: BorderRadius.circular(4.0),
               border: Border.all(color: const Color(0xffF2F2F2)),
             ),
             child: Row(
               children: [
                 const Icon(
                   Icons.location_on_outlined,
                   color: Color(0xff6A6A6A),
                   size: 16,
                 ),
                 const SizedBox(width: 10),
                 Text(
                   addController.selectedLocation.value.isNotEmpty
                       ? addController.selectedLocation.value
                       : 'নির্বাচন করুন',
                   style: TextStyle(
                     color: addController.selectedLocation.value.isNotEmpty
                         ? const Color(0xff202020)
                         : const Color(0xff6A6A6A),
                     fontSize: 14,
                     fontWeight: FontWeight.w400,
                   ),
                 ),
               ],
             ),
           )),
         ),
       ],
     );
   }


   String _selectLocation() {
     List<String> countries = ['Bangladesh', 'India', 'Pakistan', 'Bhutan'];
     Random random = Random();
     int index = random.nextInt(countries.length);
     return countries[index];
   }

  Widget _dateWidget(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('তারিখ ও সময়', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),),
        GestureDetector(
          onTap: () async {
            addController.pickedDate.value = await _selectDate(context);
          },
          child: Obx(()=>
              Container(
                height: 50,
                padding: [10,15].pm,
                decoration: BoxDecoration(
                  color: const Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: const Color(0xffF2F2F2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Color(0xff6A6A6A),
                      size: 16,
                    ),
                    10.pw,
                    Expanded(
                      child: Text(
                        addController.pickedDate.value.isNotEmpty
                            ? addController.pickedDate.value.toString()
                            : 'নির্বাচন করুন',
                        style: TextStyle(
                          color: addController.pickedDate.value.isNotEmpty ? const Color(0xff202020) : const Color(0xff6A6A6A),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff6A6A6A),
                      size: 16,
                    ),
                  ],
                ),
              )
          ),
        ),
      ],
    );
  }

   Future<String> _selectDate(BuildContext context) async {
     final DateTime? picked = await showDatePicker(
       context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime(2000),
       lastDate: DateTime(2100),
       builder: (BuildContext context, Widget? child) {
         return Theme(
           data: ThemeData.light().copyWith(
             colorScheme: const ColorScheme.light(primary: Color(0xff86B560)),
           ),
           child: child!,
         );
       },
     );
     if(picked != null) {
       return DateFormat('yyyy-MM-dd').format(picked);
     }

     return '';
   }

  Widget _categoryWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('অনুচ্ছেদের বিভাগ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),),
    GestureDetector(
      onTap: () async {
        String? category = await _showCategoryDialog(context);
        if (category != null) {
          addController.selectedCategory.value = category;
        }
    },
    child: Obx(()=>
        Container(
          height: 50,
          padding: [0,10].pm,
          decoration: BoxDecoration(
            color: const Color(0xffF2F2F2),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: const Color(0xffF2F2F2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                addController.selectedCategory.value.isNotEmpty? addController.selectedCategory.value : 'অনুচ্ছেদের বিভাগ নির্বাচন করুন',
                style: TextStyle(
                  color: addController.selectedCategory.value.isEmpty? const Color(0xff6A6A6A) : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xff6A6A6A),
                size: 16,
              ),
            ],
          ),
        )),
    )

    ],
    );
  }

   Future<String?> _showCategoryDialog(BuildContext context) {
     return showDialog<String>(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           title: const Text('নির্বাচন করুন'),
           content: SingleChildScrollView(
             child: Column(
               children: addController.model.categories.map((category) {
                 return ListTile(
                   title: Text(category),
                   onTap: () {
                     Navigator.of(context).pop(category);
                   },
                 );
               }).toList(),
             ),
           ),
         );
       },
     );
   }

  Widget _textWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('অনুচ্ছেদ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),),
              Text('৪৫ শব্দ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff6A6A6A)),),
            ],
          ),
        8.ph,
        TextField(
          controller: TextEditingController(),
          maxLines: 1,
          decoration: InputDecoration(
            fillColor: const Color(0xffF2F2F2),
            filled: true,
            constraints: const BoxConstraints(maxHeight: 50),
            hintText: 'অনুচ্ছেদ লিখুন',
            hintStyle: const TextStyle(color: Color(0xff6A6A6A), fontSize: 14, fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: Color(0xffF2F2F2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: Color(0xffF2F2F2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: Color(0xffF2F2F2)),
            ),
          ),
          textInputAction: TextInputAction.done,
          inputFormatters: [_wordLimitFormatter(45)],
        ),
      ],
    );
  }

   Widget _descriptionWidget() {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         const Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               'অনুচ্ছেদের বিবরণ',
               style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.w700,
                 color: Colors.black,
               ),
             ),
             Text(
               '১২০ শব্দ',
               style: TextStyle(
                 fontSize: 14,
                 fontWeight: FontWeight.w400,
                 color: Color(0xff6A6A6A),
               ),
             ),
           ],
         ),
         8.ph,
         IntrinsicHeight(
           child: ConstrainedBox(
             constraints: const BoxConstraints(
               minHeight: 100,
               maxHeight: 200,
             ),
             child: TextField(
               controller: TextEditingController(),
               maxLines: null,
               decoration: InputDecoration(
                 fillColor: const Color(0xffF2F2F2),
                 filled: true,
                 hintText: 'কার্যক্রমের বিবরণ লিখুন',
                 hintStyle: const TextStyle(
                   color: Color(0xff6A6A6A),
                   fontSize: 14,
                   fontWeight: FontWeight.w400,
                 ),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(4.0),
                   borderSide: const BorderSide(color: Color(0xffF2F2F2)),
                 ),
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(4.0),
                   borderSide: const BorderSide(color: Color(0xffF2F2F2)),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(4.0),
                   borderSide: const BorderSide(color: Color(0xffF2F2F2)),
                 ),
               ),
               textInputAction: TextInputAction.newline,
               inputFormatters: [_wordLimitFormatter(120)],
             ),
           ),
         ),
       ],
     );
   }

  TextInputFormatter _wordLimitFormatter(int maxWords) {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final wordList = newValue.text.split(RegExp(r'\s+'));
      if (wordList.length <= maxWords) {
        return newValue;
      }
      final truncated = wordList.take(maxWords).join(' ');
      return TextEditingValue(
        text: truncated,
        selection: TextSelection.collapsed(offset: truncated.length),
      );
    });
  }

   Widget _saveButton(BuildContext context) {
     return InkWell(
       onTap: (){
         _showSavedDialog(context);
       },
       child: Padding(
         padding: [0,20,10,20].pm,
         child: Container(
           height: 50,
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
               'সংরক্ষন করুন',
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 18,
                 fontWeight: FontWeight.w700,
               ),
             ),
           ),
         ),
       ),
     );
   }

   void _showSavedDialog(BuildContext context) {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           content: Column(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               30.ph,
               Image.asset('assets/images/saved.png', height: 96, width: 96,),
               10.ph,
               const Text('নতুন অনুচ্ছেদ সংরক্ষন', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),),
               10.ph,
               Wrap(
                   children: [
                     SizedBox(
                         width: MediaQuery.of(context).size.width-30,
                         child: const Text('আপনার সময়রেখাতে নতুন অনুচ্ছেদ সংরক্ষণ সম্পুর্ন হয়েছে ', style: TextStyle(color: Color(0xff6A6A6A), fontWeight: FontWeight.w400, fontSize: 14),))
                   ],
                   ),
               30.ph,
               _addMoreButton(context),
             ],
           ),
         );
       },
     );
   }

   Widget _addMoreButton(BuildContext context) {
     return InkWell(
       onTap: (){
          addController.selectedLocation.value = '';
          addController.selectedCategory.value = '';
          addController.pickedDate.value = '';
          Navigator.of(context).pop();
       },
       child: Padding(
         padding: [0,20,10,20].pm,
         child: Container(
           height: 50,
           width: 210,
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
               'আরও যোগ করুন',
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 18,
                 fontWeight: FontWeight.w700,
               ),
             ),
           ),
         ),
       ),
     );
   }


}
