import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:vnmo_mis/controllers/mis_controller.dart';
import 'package:vnmo_mis/pages/clients/widgets/target_data.dart';
import 'package:vnmo_mis/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../controllers/transaction_controller.dart';
import '../../helpers/responsiveness.dart';
import '../clients/widgets/special_booking.dart';
import 'widgets/drivers_table.dart';

class MisPage extends StatelessWidget {
  const MisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.orange,
    );

    final TransactionController counterController = Get.put(TransactionController());
    final MisController misController = Get.put(MisController());

    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(

                    text: "${menuController.activeItem.value} VNMO Data of AP: ${counterController.getApName()}" ,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            )),
        const SizedBox(height: 10),
        Row(
          children: [
            // ElevatedButton(
            //     onPressed: () {
            //       counterController.refreshList();
            //     },
            //     child: const Text("Refresh List")),
            // const SizedBox(width: 9),
            // ElevatedButton(
            //     onPressed: () {
            //       counterController.getTransactionToday();
            //     },
            //     child: const Text("Sort By Today")),
            // const SizedBox(width: 9),
            // ElevatedButton(
            //     onPressed: () {
            //       counterController.getTransaction();
            //     },
            //     child: const Text("Default Weekly List")),
            const SizedBox(width: 9),
            // ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.orange,
            //     ),
            //     onPressed: () async {
            //       var values = await showCalendarDatePicker2Dialog(
            //         context: context,
            //         config: config,
            //         dialogSize: const Size(325, 400),
            //         borderRadius: const BorderRadius.all(Radius.circular(15)),
            //         initialValue: [],
            //         dialogBackgroundColor: Colors.white,
            //       );
            //       if (values != null) {
            //         counterController.getValueText(
            //           config.calendarType,
            //           values,
            //         );
            //       }
            //     },
            //     child: const Text("Select Year")),
            const SizedBox(width: 9),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const TargetData();
                      }).then((value) {
                    misController.onInit();
                  });
                },
                child: const Text("Input Target")),

            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const DialogSpecialBooking();
                      }).then((value) {
                    counterController.onInit();
                  });
                },
                child: const Text("Input Data Mis")),
          ],
        ),
        const SizedBox(height: 30),
        Expanded(
          child: DriversTable(),
        ),
      ],
    );
  }
}
