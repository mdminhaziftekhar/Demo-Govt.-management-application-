import 'package:flutter_task/index.dart';
import 'package:get/get.dart';

class AddController extends GetxController {
  AddNewModel model = AddNewModel();

  RxString selectedCategory = ''.obs;
  RxString selectedLocation = ''.obs;

  RxString pickedDate = "".obs;


}