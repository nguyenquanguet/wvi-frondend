// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnmo_mis/controllers/mis_controller.dart';
import 'package:vnmo_mis/pages/clients/widgets/input_mis_data.dart';
import 'package:vnmo_mis/pages/clients/widgets/input_target.dart';
import 'package:vnmo_mis/widgets/custom_text.dart';

import '../../constants/controllers.dart';
import '../../controllers/transaction_controller.dart';
import '../../helpers/responsiveness.dart';
import '../../service/storage/constant_name.dart';
import 'widgets/ap_mis_table.dart';

class MisPage extends StatelessWidget {
  MisPage({super.key});

  final MisController misController = Get.put(MisController());
  final year = TextEditingController();
  int? nowYear;
  bool isLoading = true;

  List<String> month = [
    "October",
    "November",
    "December",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September"
  ];

  int? getMonth(var month) {
    switch (month) {
      case "October":
        return 10;
      case "November":
        return 11;
      case "December":
        return 12;
      case "January":
        return 1;
      case "February":
        return 2;
      case "March":
        return 3;
      case "April":
        return 4;
      case "May":
        return 5;
      case "June":
        return 6;
      case "July":
        return 7;
      case "August":
        return 8;
      case "September":
        return 9;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TransactionController counterController =
        Get.put(TransactionController());
    final MisController misController = Get.put(MisController());
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 100 : 20),
                  child: CustomText(
                    text:
                        "${menuController.activeItem.value} DATA AP: ${counterController.getApName()} of Year $nowYear",
                    size: ResponsiveWidget.isSmallScreen(context) ? 16 : 24,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            )),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              width: ResponsiveWidget.isSmallScreen(context) ? 160 : 200,
              height: 100,
              alignment: Alignment.center,
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Select Month',
                      errorStyle:
                          TextStyle(color: Colors.orange, fontSize: 10.0),
                      hintText: 'Please select Month',
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        hint: const Text('Please select Month'),
                        isDense: true,
                        onChanged: (String? newValue) async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          int? inputMonth = getMonth(newValue.toString());
                          pref.setInt(ConstantName().month, inputMonth!);
                        },
                        items: month.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: true,
              replacement: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                        ResponsiveWidget.isSmallScreen(context) ? 160 : 200,
                        80),
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return const InputTarget();
                        }).then((value) {
                      misController.onInit();
                    });
                  },
                  child: const Text("Input Target")),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                        ResponsiveWidget.isSmallScreen(context) ? 160 : 200,
                        80),
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return const InputMISData();
                        }).then((value) {
                      misController.onInit();
                    });
                  },
                  child: const Text("Input Data")),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ApMisTable(),
        ),
      ],
    );
  }
}
