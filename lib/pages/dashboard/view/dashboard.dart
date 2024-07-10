import 'package:flutter/material.dart';
import 'package:flutter_task/index.dart';
import 'package:flutter_task/main.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
   DashboardScreen({super.key});

  final DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return
        SingleChildScrollView(
          child: Padding(
            padding: [0, 20, 0, 20].pm,
            child: Column(
              children: [
                _profileInfo(),
                20.ph,
                _timeDetailsWidget(),
                20.ph,
                _buildMenu(),
              ],
                ),
          ),
        );
  }

  Widget _buildMenu() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: (dashboardController.model.menuItemImages.length / 3).ceil(), // Calculate number of rows
      itemBuilder: (context, index) {
        int startIndex = index * 3;
        int endIndex = startIndex + 3 < dashboardController.model.menuItemImages.length ? startIndex + 3 : dashboardController.model.menuItemNames.length;
        List<String> rowItems = dashboardController.model.menuItemImages.sublist(startIndex, endIndex);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rowItems.asMap().entries.map((entry) {
            int index = entry.key;
            String item = entry.value;
            return Column(
              children: [
                Container(
                  width: 72,
                  height: 74,
                  margin: [8].pm,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: const Color(0xffF6F6F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset(item, height: 38, width: 38,),
                  ),
                ),
                2.ph,
                Text(dashboardController.model.menuItemNames[index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),),
                5.ph,
              ],
            );
          }).toList(),
        );
      },
    );
  }

  Widget _timeDetailsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _progressIndicator(),
        10.pw,
        _expiringDateWidget(),
      ],
    );
  }

  Widget _expiringDateWidget() {

    List<String> time = dashboardController.getRemainingYearsMonthsDays();
    String banglaYears = time[0];
    String banglaMonths = time[1];
    String banglaDays = time[2];

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('মেয়াদকাল', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),),
          2.ph,
           Row(
            children: [
              const Icon(Icons.calendar_month_rounded, size: 14, color: Colors.black,),
              2.pw,
              const Text('১ই জানুয়ারি ২০২৪ - ৩১ই জানুয়ারি ২০৩০', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),)
            ],
          ),
          5.ph,
          const Text('আরও বাকি', style: TextStyle(color: Color(0xffFF737A), fontWeight: FontWeight.w700, fontSize: 16),),
          4.ph,
          Row(
            children: [
              _validityContainer(time: banglaYears, title: 'বছর'),
              10.pw,
              _validityContainer(time: banglaMonths, title: 'মাস'),
              10.pw,
              _validityContainer(time: banglaDays, title: 'দিন'),
            ],
          )

        ],
    );
  }

  Widget _validityContainer({required String time, required String title}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: const Color(0xffF6F6F6), border: Border.all(color: const Color(0xffFF737A), width: 1),
              ),
              child: Center(
                child: Text(time[0], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: Colors.black),),
              ),
            ),
            5.pw,
            Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: const Color(0xffF6F6F6), border: Border.all(color: const Color(0xffFF737A), width: 1),
              ),
              child: Center(
                child: Text(time[1], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: Colors.black),),
              ),
            ),
          ],
        ),
        2.ph,
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black), )
      ],
    );
  }

  Widget _progressIndicator() {
    List monthsDays = dashboardController.getMonthAndDaysPassed();
    String months = monthsDays.first;
    String days = monthsDays.last;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: dashboardController.getProgressPercentage(),
                    strokeWidth: 10,
                    color: const Color(0xff86B560),
                    backgroundColor: Colors.grey.withOpacity(0.2),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$months মাস ',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '$days দিন',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),
        10.ph,
        const Text('সময় অতিবাহিত', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),)
      ],
    );
  }

  Widget _profileInfo() {
    return Container(
       height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Image.asset('assets/images/profile.png', height: 60, width: 60,)),
           Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('মোঃ মোহাইমেনুল রেজা', style: TextStyle(
                    color: Color(0xff202020),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),),
                  const Text('সফটবিডি লিমিটেড', style: TextStyle(
                    color: Color(0xff6A6A6A),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 18,),
                      2.pw,
                      const Text('ঢাকা', style: TextStyle(
                        color: Color(0xff6A6A6A),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
