import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnmo_mis/controllers/mis_controller.dart';
import 'package:vnmo_mis/pages/clients/widgets/input_mis_data.dart';
import 'package:vnmo_mis/widgets/custom_text.dart';

import '../../constants/controllers.dart';
import '../../controllers/transaction_controller.dart';
import '../../helpers/responsiveness.dart';
import '../../service/storage/constant_name.dart';
import 'widgets/ap_mis_table.dart';

class MisPage extends StatelessWidget {

  final MisController misController = Get.put(MisController());
  final year = TextEditingController();

  final List<String> listYear = ["FY22", "FY23"];

  MisPage({super.key});

  int? getYear (String year){
    switch(year){
      case "FY22":
        return 2022;
      case "FY23":
        return 2023;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TransactionController counterController =
        Get.put(TransactionController());
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 100 : 20),
                  child: CustomText(
                    text:
                        "${menuController.activeItem.value} VNMO Data of AP: ${counterController.getApName()}",
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
              width: ResponsiveWidget.isSmallScreen(context) ? 160 : 180,
              height: 100,
              alignment: Alignment.center,
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: const InputDecoration(
                        labelText: 'Select FY',
                        errorStyle: TextStyle(
                            color: Colors.orange, fontSize: 10.0),
                        hintText: 'Please select FY',),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          return 'Please enter FY';
                        },
                        hint: const Text('Please select FY'),
                        isDense: true,
                        onChanged: (String? newValue) async {
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          int? inputYear = getYear(newValue.toString());
                          pref.setInt(ConstantName().year, inputYear!);
                        },
                        items: listYear.map((String value) {
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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(ResponsiveWidget.isSmallScreen(context) ? 160 : 180, 80),
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const TargetData();
                      }).then((value) {
                    misController.onInit();
                  });
                },
                child: const Text("Input Data")),
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
