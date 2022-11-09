import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vnmo_mis/controllers/mis_controller.dart';
import 'package:vnmo_mis/model/indicator.dart';
import 'package:vnmo_mis/model/tp.dart';
import 'package:vnmo_mis/service/mis_service.dart';

class TargetData extends StatefulWidget {
  const TargetData({Key? key}) : super(key: key);

  @override
  _TargetData createState() => _TargetData();
}

class _TargetData extends State<TargetData> {
  final MisService _misService = MisService();

  final MisController counterController = Get.put(MisController());

  final targetNumber = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = true;

  List<DataTp> listTp = [];
  List<DataIndicator> indicatorList = [];

  var _selectYear;
  var _selectedIndicatorCode;

  DateTime? chooseDateApi;

  @override
  void initState() {
    getApTpList();
    getIndicatorList();
    super.initState();
  }

  void getApTpList() async {
    Tp tpApList = await _misService.getAppTp();
    listTp = tpApList.data!;
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading = false;
      setState(() {});
    });
  }

  void getIndicatorList() async {
    Indicator indicator = await _misService.getApIndicator();
    indicatorList = indicator.data!;
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
        "Target year for indicator",
        style: const TextStyle(fontSize: 24.0),
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
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  labelText: 'Year',
                                  errorStyle: const TextStyle(
                                      color: Colors.orange, fontSize: 16.0),
                                  hintText: 'Please select year',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              isEmpty: _selectYear == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  validator: (value) {
                                    if (_selectYear == null ||
                                        _selectYear.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  hint: const Text(
                                      'Please select indicator code'),
                                  value: _selectYear,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectYear = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: listTp.map((DataTp value) {
                                    return DropdownMenuItem<String>(
                                      value: value.id.toString(),
                                      child: Text(value.name!),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                  labelText: 'Indicator Code',
                                  errorStyle: const TextStyle(
                                      color: Colors.orange, fontSize: 16.0),
                                  hintText: 'Please select indicator code',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0))),
                              isEmpty: _selectedIndicatorCode == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  validator: (value) {
                                    if (_selectedIndicatorCode == null ||
                                        _selectedIndicatorCode.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  hint: const Text(
                                      'Please select indicator code'),
                                  value: _selectedIndicatorCode,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedIndicatorCode = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items:
                                      indicatorList.map((DataIndicator value) {
                                    return DropdownMenuItem<String>(
                                      value: value.id.toString(),
                                      child: Text("${value.code}"),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onChanged: (value) {
                            try {
                              if (value == "") {
                                targetNumber.text = "0";
                                return;
                              }
                            } catch (e) {
                              targetNumber.text = "0";
                            }
                          },
                          controller: targetNumber,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Target Indicator',
                              labelText: 'Target Year'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                          width: MediaQuery.of(context).size.width / 5,
                          height: 60,
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              // fixedSize: Size(250, 50),
                            ),
                              child: const Text(
                                "Cancel",
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 5,
                            height: 60,
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // var jsons = {
                                  //   "activitiesId":
                                  //   _selectedActivity.toString(),
                                  //   "totalBookedSlot": totalPerson.text,
                                  //   "dateSlot": chooseDateApi.toString(),
                                  //   "shiftSlotId": _selectedSession.toString(),
                                  //   "firstNameRegister": personName.text,
                                  //   "firstPhoneNumberRegister":
                                  //   phoneNumber.text,
                                  //   "firstEmailRegister": emailPerson.text,
                                  //   "temporaryUnique": "custom",
                                  //   "totalPrice": totalPrice.text
                                  // };
                                  // int status = await _activityService
                                  //     .goToInsertSpecialBooking(jsons);
                                  // if (status == 200) {
                                  //   AwesomeDialog(
                                  //     width: checkConditionWidth(context),
                                  //     bodyHeaderDistance: 60,
                                  //     context: context,
                                  //     animType: AnimType.SCALE,
                                  //     dialogType: DialogType.SUCCES,
                                  //     body: const Center(
                                  //       child: Text(
                                  //         'Insert Successfully for special booking.',
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.normal,
                                  //             fontSize: 16),
                                  //         textAlign: TextAlign.center,
                                  //       ),
                                  //     ),
                                  //     title: 'Booking for ${personName.text}',
                                  //     desc: '',
                                  //     btnOkOnPress: () {
                                  //       Navigator.of(context).pop();
                                  //     },
                                  //   ).show();
                                  // } else {
                                  //   AwesomeDialog(
                                  //     width: checkConditionWidth(context),
                                  //     bodyHeaderDistance: 60,
                                  //     context: context,
                                  //     animType: AnimType.SCALE,
                                  //     dialogType: DialogType.ERROR,
                                  //     body: const Center(
                                  //       child: Text(
                                  //         'Failed to special booking please try again.',
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.normal,
                                  //             fontSize: 16),
                                  //         textAlign: TextAlign.center,
                                  //       ),
                                  //     ),
                                  //     title: 'Failed',
                                  //     desc: '',
                                  //     btnOkOnPress: () {},
                                  //   ).show();
                                  // }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                // fixedSize: Size(250, 50),
                              ),
                              child: const Text(
                                "Submit",
                              )),
                            )
                          ]
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
