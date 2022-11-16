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

class ReviewInputMisData extends StatefulWidget {
  const ReviewInputMisData({Key? key}) : super(key: key);

  @override
  _ReviewInputMisData createState() => _ReviewInputMisData();
}

class _ReviewInputMisData extends State<ReviewInputMisData> {

  final MisService _misService = MisService();

  final MisController counterController = Get.put(MisController());

  String? selectApName;
  String? selectTpName;
  String? selectIndicatorCode;
  int? year;
  int? month;
  int? selectActualAchieve;
  int? selectBoyNumber;
  int? selectGirlNumber;
  int? selectMaleNumber;
  int? selectFemaleNumber;
  int? selectMvcNumber;
  int? selectRcNumber;
  int? selectD1Number;
  int? selectD2Number;
  int? selectD3Number;
  String? selectIndicatorDescription;

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
    selectApName = pref.getString(ConstantName().apName);
    selectBoyNumber = pref.getInt(ConstantName().selectBoyNumber)!;
    selectGirlNumber = pref.getInt(ConstantName().selectGirlNumber)!;
    selectMaleNumber = pref.getInt(ConstantName().selectMaleNumber)!;
    selectFemaleNumber = pref.getInt(ConstantName().selectFemaleNumber)!;
    selectMvcNumber = pref.getInt(ConstantName().selectMvcNumber)!;
    selectRcNumber = pref.getInt(ConstantName().selectRcNumber)!;
    selectD1Number = pref.getInt(ConstantName().selectD1Number)!;
    selectD2Number = pref.getInt(ConstantName().selectD2Number)!;
    selectD3Number = pref.getInt(ConstantName().selectD3Number)!;
    selectActualAchieve = pref.getInt(ConstantName().selectActualAchieve);
    selectIndicatorDescription = pref.getString(ConstantName().selectIndicatorDescription);
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
                    initialValue: "$selectIndicatorCode: $selectIndicatorDescription",
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'INDICATOR ID'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: selectActualAchieve.toString(),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ACTUAL ACHIEVED'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: selectBoyNumber.toString(),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'BOY NUMBER'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: selectGirlNumber.toString(),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'GIRL NUMBER'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: selectMaleNumber.toString(),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'MALE NUMBER'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: selectFemaleNumber.toString(),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'FEMALE NUMBER'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: selectMvcNumber.toString(),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'MVC NUMBER'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: selectRcNumber.toString(),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'RC NUMBER'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: selectD1Number.toString(),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'D1 NUMBER'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: selectD2Number.toString(),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'D2 NUMBER'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    initialValue: selectD2Number.toString(),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'D2 NUMBER'),
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
                                  "month":
                                  prefs.getInt(ConstantName().month),
                                  "actualAchieve": selectActualAchieve,
                                  "boyNumber": selectBoyNumber,
                                  "girlNumber": selectGirlNumber,
                                  "maleNumber": selectMaleNumber,
                                  "femaleNumber": selectFemaleNumber,
                                  "mvc": selectMvcNumber,
                                  "rc": selectRcNumber,
                                  "d1": selectD1Number,
                                  "d2": selectD2Number,
                                  "d3": selectD3Number
                                };
                                int status =
                                await _misService.createData(jsons);
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
