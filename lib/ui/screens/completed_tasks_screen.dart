import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/compleate_task_controller.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {

  @override
  void initState() {
    super.initState();
   Get.find<CompleateTaskController>().getCompleateTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: GetBuilder<CompleateTaskController>(
                builder: (compleatetaskcontroller) {
                  return Visibility(
                    visible: compleatetaskcontroller.getCompleateTaskInProgress == false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: RefreshIndicator(
                      onRefresh: () => compleatetaskcontroller.getCompleateTaskList(),
                      child: ListView.builder(
                        itemCount: compleatetaskcontroller.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: compleatetaskcontroller.taskListModel.taskList![index],
                            onStatusChange: () {
                              compleatetaskcontroller.getCompleateTaskList();
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
      ),
    );
  }
}
