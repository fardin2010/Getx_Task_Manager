import 'package:flutter/material.dart';
import 'package:get/get.dart';
void showSnackMessage(
    String message,
    [bool isError = false]) {(
Get.snackbar(
  message,"",
  backgroundColor: isError ? Colors.red : null,
  snackPosition: SnackPosition.BOTTOM,
),
);
}
