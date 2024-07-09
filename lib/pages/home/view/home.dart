import 'package:flutter/material.dart';
import 'package:flutter_task/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              _notificationButtonWidget(),
            ],
            title: _titleWidget(),
          ),
          drawer: _drawerWidget(),
          body: const Column(
            children: [
              Text('TEST'),
            ],
          ),
        ));
  }

  Widget _drawerWidget() {
    return const Drawer(
      backgroundColor: Colors.white,
      child: DrawerHeader(decoration: BoxDecoration(gradient: LinearGradient(
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
    return Row(
      children: [
        Image.asset('assets/images/demo.png', width: 37, height: 37),
        5.pw,
        const Text('Flutter Task', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),)
      ],
    );
  }

  Widget _notificationButtonWidget() {
    return IconButton(
      icon: Image.asset('assets/images/notification.png', width: 35, height: 35,),
      onPressed: (){},
    );
  }
}
