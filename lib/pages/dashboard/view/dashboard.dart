import 'package:flutter/material.dart';
import 'package:flutter_task/index.dart';
import 'package:flutter_task/main.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return
        Column(
          children: [
            _profileInfo(),
          ],
    );
  }
  
  Widget _profileInfo() {
    return Padding(
      padding: [0, 20, 0, 20].pm,
      child: Container(
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
      ),
    );
  }
}
