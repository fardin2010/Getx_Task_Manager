import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class CancleTaskController extends GetxController {
  bool _getCancleTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getCancleTaskInProgress => _getCancleTaskInProgress;

  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCancleTaskList() async {
    bool isSuccess = false;
    _getCancleTaskInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCancledTasks);
    _getCancleTaskInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
