import 'package:vnmo_mis/pages/clients/widgets/add_activity.dart';
import 'package:vnmo_mis/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../controllers/activity_controller.dart';
import '../../helpers/responsiveness.dart';
import 'widgets/clients_table.dart';

class ClientsPage extends StatelessWidget {
  ClientsPage({Key? key}) : super(key: key);
  final ActivityController counterController = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            )),
        const SizedBox(height: 10),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const DialogAddActivity();
                      }).then((value) {
                    counterController.onInit();
                  });
                },
                child: const Text("Add New Activity")),
            const SizedBox(width: 9),
          ],
        ),
        const SizedBox(height: 30),
        const Expanded(
          child: ClientsTable(),
        ),
      ],
    );
  }
}
