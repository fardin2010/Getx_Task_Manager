import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/Cancle_Task_Controller.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/task_item_card.dart';
import 'package:get/get.dart';

class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({super.key});

  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}
class _CancelledTasksScreenState extends State<CancelledTasksScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<CancleTaskController>().getCancleTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: GetBuilder<CancleTaskController>(
                builder: (cancleTaskcontroller) {
                  return Visibility(
                    visible: cancleTaskcontroller.getCancleTaskInProgress == false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: RefreshIndicator(
                      onRefresh: () => cancleTaskcontroller.getCancleTaskList(),
                      child: ListView.builder(
                        itemCount: cancleTaskcontroller.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: cancleTaskcontroller.taskListModel.taskList![index],
                            onStatusChange: () {
                              cancleTaskcontroller.getCancleTaskList();
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
