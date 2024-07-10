import 'package:flutter/material.dart';
import 'package:flutter_task/main.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(()=>  Scaffold(
          appBar: AppBar(
            actions: [
              _notificationButtonWidget(),
            ],
            centerTitle: homeController.selectedIndex.value==0? false:true,
            title: _titleWidget()),
          drawer: _drawerWidget(),
          bottomNavigationBar: _bottomNavigationBar(),
          body: const Column(
            children: [
              Text('TEST'),
            ],
          ),
        )));
  }

  Widget _bottomNavigationBar() {
    return Obx(()=>
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Row(
                    children: [
                      Expanded(child: InkWell(
                          onTap: (){
                            homeController.onItemTapped(0);
                          },
                          child: Image.asset(homeController.selectedIndex.value==0? 'assets/images/home_selected.png' : 'assets/images/home_unselected.png', width: 28, height: 28))),
                      Expanded(child: InkWell(
                          onTap: (){
                            homeController.onItemTapped(1);
                          },
                          child: Image.asset(homeController.selectedIndex.value==1? 'assets/images/calendar_selected.png' : 'assets/images/calendar_unselected.png', width: 28, height: 28))),
                    ],
                  )),
                  100.pw,
                  Expanded(child: Row(
                    children: [
                      Expanded(child: InkWell(child: Image.asset('assets/images/tab3.png', width: 28, height: 28))),
                      Expanded(child: InkWell(child: Image.asset('assets/images/tab4.png', width: 28, height: 28))),
                    ],
                  )),
                ],
              ),
            ),
            Positioned(
              top: -35,
              left: 0,
              right: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/ellipse.png', width: 100, height: 100),
                  Image.asset('assets/images/camera.png', width: 40, height: 40),
                ],
              ),
            ),
          ],
        )
    );
  }

  Widget _drawerWidget() {
    return const Drawer(
      backgroundColor: Colors.white,
      child: DrawerHeader(
        decoration: BoxDecoration(gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.6, 1),
        colors: [
          Color(0xff86B560),
          Color(0xff336F4A),
        ],
      ),),
        child: Text('Flutter test task', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),),
    );
  }

  Widget _titleWidget() {
    return Obx(()=>
        Row(
          mainAxisSize: MainAxisSize.min,
        children: [
          if(homeController.selectedIndex.value==0)...[
            Image.asset('assets/images/demo.png', width: 37, height: 37),
            5.pw,
          ],
          Text(homeController.selectedIndex.value==0? 'Flutter Task' : 'সময়রেখা', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),)
      ],
    ));
  }

  Widget _notificationButtonWidget() {
    return IconButton(
      icon: Image.asset('assets/images/notification.png', width: 35, height: 35,),
      onPressed: (){},
    );
  }
}
