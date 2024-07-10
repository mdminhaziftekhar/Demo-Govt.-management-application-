
import 'package:flutter_task/pages/home/model/home_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  HomeModel model = HomeModel();

  RxInt selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }


}