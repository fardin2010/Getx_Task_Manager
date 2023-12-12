
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/add_new_task_controller.dart';
import '../widgets/body_background.dart';
import '../widgets/profile_summary_card.dart';
import '../widgets/snack_message.dart';


class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   final _addNewTaskController = Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _addNewTaskController.newTaskAdded);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const ProfileSummaryCard(),
              Expanded(
                child: BodyBackground(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 32,),
                            Text('Add New Task', style: Theme.of(context).textTheme.titleLarge,),
                            const SizedBox(height: 16,),
                            TextFormField(
                              controller: _subjectTEController,
                              decoration: const InputDecoration(
                                hintText: 'Subject'
                              ),
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return 'Enter your subject';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8,),
                            TextFormField(
                              controller: _descriptionTEController,
                              maxLines: 8,
                              decoration: const InputDecoration(
                                hintText: 'Description'
                              ),
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return 'Enter your description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16,),
                            SizedBox(
                              width: double.infinity,
                              child: GetBuilder<AddNewTaskController>(
                                builder: (addNewTaskController) {
                                  return Visibility(
                                    visible: addNewTaskController.createTaskInProgress == false,
                                    replacement: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: createTask,
                                      child: const Icon(Icons.arrow_circle_right_outlined),
                                    ),
                                  );
                                }
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> createTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final response = await _addNewTaskController.createTask(
        _subjectTEController.text.trim(),
        _descriptionTEController.text.trim(),
        "New",
    );
    if (response) {
      showSnackMessage("New Task has been added");
    } else {
      showSnackMessage("Task creation Failed",true);
    }
  }


  @override
  void dispose() {
    _descriptionTEController.dispose();
    _subjectTEController.dispose();
    super.dispose();
  }
}
