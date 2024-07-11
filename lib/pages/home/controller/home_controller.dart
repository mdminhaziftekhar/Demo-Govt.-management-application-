
import 'package:flutter/material.dart';
import 'package:flutter_task/core/db/DAL/task_respository.dart';
import 'package:flutter_task/pages/home/model/home_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import '../../../core/db/entities/data_entity.dart';
import '../../../core/utils/network_utils.dart';
import '../../calendar/controller/calendar_controller.dart';

class HomeController extends GetxController {

  HomeModel model = HomeModel();

  @override
  void onInit() {
    getDataAndSaveInDB();

    super.onInit();
  }

  RxInt selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  void resetCalendarState() {
    final CalendarController calendarController = Get.find();
    calendarController.selectedDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Future<void> getDataAndSaveInDB() async {
    NetworkUtils().fetchingData = true;
    dio.Response response =  await NetworkUtils().get('/bc69ae1f6991da81ab9a');

    if(response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {

      TaskRepository<DataEntity> dataRepository = await TaskRepository.init();

      if(response.data['data'] != null) {
          await dataRepository.deleteAllRows();

          List<dynamic> data = response.data['data']??[];

          for (var element in data) {
            try{
              await dataRepository.put(data: DataEntity.fromMap(element));
            }catch(e){
              NetworkUtils().fetchingData = false;
            }
          }
          NetworkUtils().fetchingData = false;
          // List<DataEntity> list = await dataRepository.getAll();
          // print('');
      }

    } else {
      NetworkUtils().fetchingData = false;
      debugPrint('Error fetching data!');
    }
  }


}