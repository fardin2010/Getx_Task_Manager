import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class CompleateTaskController extends GetxController {
  bool _getCompleateTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCompleateTaskInProgress => _getCompleateTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCompleateTaskList() async {
    bool isSuccess = false;
    _getCompleateTaskInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCompleatedTasks);
    _getCompleateTaskInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
