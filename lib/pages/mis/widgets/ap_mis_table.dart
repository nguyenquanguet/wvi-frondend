import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnmo_mis/controllers/mis_controller.dart';

import '../../../constants/style.dart';
import '../../../controllers/transaction_controller.dart';
import '../../../widgets/custom_text.dart';

class ApMisTable extends StatelessWidget {
  ApMisTable();

  final MisController misController = Get.put(MisController());

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
        () => misController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 1200,
                columns: const [
                  DataColumn2(label: Text('Indicator Code'), fixedWidth: 120),
                  DataColumn(
                    label: Text('Year'),
                  ),
                  DataColumn(
                    label: Text('Month'),
                  ),
                  DataColumn(
                    label: Text('Target'),
                  ),
                  DataColumn2(label: Text('Actual Achieve'), fixedWidth: 120),
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
                  DataColumn(
                    label: Text('D1'),
                  ),
                  DataColumn(
                    label: Text('D2'),
                  ),
                  DataColumn(
                    label: Text('D3'),
                  ),
                ],
                rows: misController.misDataResponseDisplay.isEmpty
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
                            ))
                          ],
                        ),
                      ]
                    : [
                        ...misController.misDataResponseDisplay.map(
                          (element) => DataRow(
                            cells: [
                              DataCell(CustomText(
                                text: element.indicatorCode.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.year.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.month.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.target.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.actualAchieve.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.boyNumber.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.girlNumber.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.maleNumber.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.femaleNumber.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.mvc.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.rc.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.d1.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.d2.toString(),
                              )),
                              DataCell(CustomText(
                                text: element.d3.toString(),
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
