import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'toy_result_logic.dart';

class ToyResultView extends GetView<PageLogic> {
  const ToyResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.schamberger.value
              ? const CircularProgressIndicator(color: Colors.deepPurpleAccent)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.bocifhde();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
