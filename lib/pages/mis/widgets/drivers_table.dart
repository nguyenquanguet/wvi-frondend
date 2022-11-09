import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/style.dart';
import '../../../controllers/transaction_controller.dart';
import '../../../widgets/custom_text.dart';

class DriversTable extends StatelessWidget {
  DriversTable({super.key});

  final TransactionController counterController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      padding: const EdgeInsets.all(16),
      child: Obx(
        () => counterController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 1200,
                columns: const [
                  DataColumn2(
                    label: Text('Indicator Code'),
                    size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text('Year'),
                  ),
                  DataColumn(
                    label: Text('Month'),
                  ),
                  DataColumn(
                    label: Text('Target'),
                  ),
                  DataColumn(
                    label: Text('Actual Achieve'),
                  ),
                  DataColumn(
                    label: Text('Boy'),
                  ),
                  DataColumn(
                    label: Text('Girl'),
                  ),
                  DataColumn(
                    label: Text('Male'),
                  ),
                  DataColumn(
                    label: Text('Female'),
                  ),
                  DataColumn(
                    label: Text('MVC'),
                  ),
                  DataColumn(
                    label: Text('RC'),
                  ),
                ],
                rows: counterController.statusResponseDisplay.isEmpty
                    ? [
                        const DataRow(
                          cells: [
                            DataCell(CustomText(
                              text: 'N/A',
                            )),
                            DataCell(CustomText(
                              text: 'N/A',
                            )),
                            DataCell(CustomText(
                              text: 'N/A',
                            )),
                            DataCell(CustomText(
                              text: 'N/A',
                            )),
                            DataCell(CustomText(
                              text: 'N/A',
                            )),
                            DataCell(CustomText(
                              text: 'N/A',
                            )),
                            DataCell(CustomText(
                              text: 'N/A',
                            )),
                            DataCell(CustomText(
                              text: 'N/A',
                            )),
                            DataCell(CustomText(
                              text: 'N/A',
                            )),
                            DataCell(CustomText(
                              text: 'N/A',
                            )),
                            // DataCell(Container(
                            //   decoration: BoxDecoration(
                            //       border: Border.all(color: active, width: 5),
                            //       color: light,
                            //       borderRadius: BorderRadius.circular(20)),
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 12, vertical: 6),
                            //   child: const CustomText(
                            //     text: "User Options",
                            //   ),
                            // )),
                            DataCell(CustomText(
                              text: 'N/A',
                            )),
                          ],
                        ),
                      ]
                    : [
                        ...counterController.statusResponseDisplay.map(
                          (element) => DataRow(
                            cells: [
                              DataCell(CustomText(
                                text: element.name,
                              )),
                              DataCell(CustomText(
                                text: element.phoneNumber,
                              )),
                              DataCell(CustomText(
                                text: element.email,
                              )),
                              DataCell(CustomText(
                                text: element.activityName,
                              )),
                              DataCell(CustomText(
                                text: element.totalBookedSlot,
                              )),
                              DataCell(CustomText(
                                text: double.parse(element.totalPrice)
                                    .toStringAsFixed(2),
                              )),
                              DataCell(CustomText(
                                text: element.shiftName,
                              )),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Chip(
                                      padding: const EdgeInsets.all(0),
                                      backgroundColor:
                                          element.statusId == "Success"
                                              ? Colors.green
                                              : Colors.red,
                                      label: CustomText(
                                        text: element.statusId,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // DataCell(Container(
                              //   decoration: BoxDecoration(
                              //       border: Border.all(color: active, width: 5),
                              //       color: light,
                              //       borderRadius: BorderRadius.circular(20)),
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 12, vertical: 6),
                              //   child: const CustomText(
                              //     text: "User Options",
                              //   ),
                              // )),
                              DataCell(CustomText(
                                text: DateFormat('dd/MM/yyyy hh:mm a')
                                    .format(element.createdDate),
                              )),
                            ],
                          ),
                        ),
                      ],
              ),
      ),
    );
  }
}
