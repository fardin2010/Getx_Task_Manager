import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class AddNewTaskController extends GetxController{
  bool _createTaskInProgress = false;

  bool get createTaskInProgress => _createTaskInProgress;
  bool newTaskAdded = false;
  Future<bool> createTask(String title,String description,String status) async {
      _createTaskInProgress = true;
      update();
      final NetworkResponse response =
      await NetworkCaller().postRequest(Urls.createNewTask, body: {
        "title": title,
        "description": description,
        "status": status,
      });
      _createTaskInProgress = false;
     update();
      if (response.isSuccess) {
        newTaskAdded = true;
        return true;
      }
      update();
      return false;
  }
}