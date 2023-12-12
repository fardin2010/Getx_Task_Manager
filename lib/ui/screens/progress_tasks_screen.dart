import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/progress_task_controller.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';

class ProgressTasksScreen extends StatefulWidget {
  const ProgressTasksScreen({super.key});

  @override
  State<ProgressTasksScreen> createState() => _ProgressTasksScreenState();
}

class _ProgressTasksScreenState extends State<ProgressTasksScreen> {


  @override
  void initState() {
    super.initState();
    Get.find<ProgressTaskController>().getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const ProfileSummaryCard(),
              Expanded(
                child: GetBuilder<ProgressTaskController>(
                    builder: (progresstaskcontroller) {
                      return Visibility(
                        visible: progresstaskcontroller.getProgressTaskInProgress == false,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: RefreshIndicator(
                          onRefresh: () => progresstaskcontroller.getProgressTaskList(),
                          child: ListView.builder(
                            itemCount: progresstaskcontroller.taskListModel.taskList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return TaskItemCard(
                                task: progresstaskcontroller.taskListModel.taskList![index],
                                onStatusChange: () {
                                 progresstaskcontroller.getProgressTaskList();
                                },
                                showProgress: (inProgress) {
                                },
                              );
                            },
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ));
  }
}
