import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnmo_mis/controllers/mis_controller.dart';
import 'package:vnmo_mis/service/mis_service.dart';
import 'package:vnmo_mis/service/storage/constant_name.dart';

import '../../../constants/condition_size.dart';
import '../../../helpers/responsiveness.dart';

class ReviewInputTarget extends StatefulWidget {
  const ReviewInputTarget({Key? key}) : super(key: key);

  @override
  _ReviewInputTarget createState() => _ReviewInputTarget();
}

class _ReviewInputTarget extends State<ReviewInputTarget> {
  final MisService _misService = MisService();

  final MisController counterController = Get.put(MisController());

  int? selectTargetNumber;
  String? selectApName;
  String? selectTpName;
  String? selectIndicatorCode;
  int? year;
  int? month;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = true;

  @override
  void initState() {
    getDataFromSharePref();
    super.initState();
  }

  void getDataFromSharePref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    year = pref.getInt(ConstantName().year);
    month = pref.getInt(ConstantName().month);
    selectTpName = pref.getString(ConstantName().selectTpName)!;
    selectIndicatorCode = pref.getString(ConstantName().selectIndicatorCode)!;
    selectTargetNumber = pref.getInt(ConstantName().selectTargetId)!;
    selectApName = pref.getString(ConstantName().apName);

    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            20.0,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        top: 10.0,
      ),
      title: const Text(
        "Confirm INPUT Target MIS",
        style: TextStyle(fontSize: 24.0),
      ),
      content: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height / 1,
              width: MediaQuery.of(context).size.width / 1.5,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          enabled: false,
                          initialValue: selectApName,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'AP NAME'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          enabled: false,
                          initialValue: year.toString(),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Year'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          enabled: false,
                          initialValue: month.toString(),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Month'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          enabled: false,
                          initialValue: selectTpName.toString(),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'TP NAME'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          enabled: false,
                          initialValue: selectIndicatorCode,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'INDICATOR ID'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          enabled: false,
                          initialValue: selectTargetNumber.toString(),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Target Indicator',
                              labelText: 'TARGET'),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width /
                                  (ResponsiveWidget.isSmallScreen(context)
                                      ? 3
                                      : 5),
                              height: 60,
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  minimumSize: Size(
                                      ResponsiveWidget.isSmallScreen(context)
                                          ? 100
                                          : 180,
                                      50),
                                ),
                                child: const Text(
                                  "Cancel",
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width /
                                  (ResponsiveWidget.isSmallScreen(context)
                                      ? 3
                                      : 5),
                              height: 60,
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    if (_formKey.currentState!.validate()) {
                                      var jsons = {
                                        "username": prefs
                                            .getString(ConstantName().username),
                                        "apId":
                                            prefs.getInt(ConstantName().apId),
                                        "indicatorCode":
                                            selectIndicatorCode.toString(),
                                        "year":
                                            prefs.getInt(ConstantName().year),
                                        "target": selectTargetNumber,
                                        "month":
                                            prefs.getInt(ConstantName().month),
                                      };
                                      int status =
                                          await _misService.createTarget(jsons);
                                      if (status == 200) {
                                        AwesomeDialog(
                                          width: checkConditionWidth(context),
                                          bodyHeaderDistance: 60,
                                          context: context,
                                          animType: AnimType.SCALE,
                                          dialogType: DialogType.SUCCES,
                                          body: const Center(
                                            child: Text(
                                              'Insert Successfully.',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          title:
                                              'Insert for ${prefs.getString(ConstantName().apName)}',
                                          desc: '',
                                          btnOkOnPress: () {
                                            Navigator.of(context).pop();
                                          },
                                        ).show();
                                      } else {
                                        AwesomeDialog(
                                          width: checkConditionWidth(context),
                                          bodyHeaderDistance: 60,
                                          context: context,
                                          animType: AnimType.SCALE,
                                          dialogType: DialogType.ERROR,
                                          body: const Center(
                                            child: Text(
                                              'Failed to create data please try again.',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          title: 'Failed',
                                          desc: '',
                                          btnOkOnPress: () {},
                                        ).show();
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    minimumSize: Size(
                                        ResponsiveWidget.isSmallScreen(context)
                                            ? 100
                                            : 180,
                                        50),
                                  ),
                                  child: const Text(
                                    "Submit",
                                  )),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
