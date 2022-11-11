import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnmo_mis/controllers/mis_controller.dart';
import 'package:vnmo_mis/model/indicator.dart';
import 'package:vnmo_mis/model/tp.dart';
import 'package:vnmo_mis/service/mis_service.dart';
import 'package:vnmo_mis/service/storage/constant_name.dart';

import '../../../constants/condition_size.dart';
import '../../../helpers/responsiveness.dart';

class TargetData extends StatefulWidget {
  const TargetData({Key? key}) : super(key: key);

  @override
  _TargetData createState() => _TargetData();
}

class _TargetData extends State<TargetData> {
  final MisService _misService = MisService();

  final MisController counterController = Get.put(MisController());

  final targetNumber = TextEditingController();
  final actualAchieve = TextEditingController();
  final boyNumber = TextEditingController();
  final girlNumber = TextEditingController();
  final maleNumber = TextEditingController();
  final femaleNumber = TextEditingController();
  final mvc = TextEditingController();
  final rc = TextEditingController();
  final d1 = TextEditingController();
  final d2 = TextEditingController();
  final d3 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = true;

  List<DataTp> listTp = [];
  List<DataIndicator> indicatorList = [];
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

  var _selectTp;
  var _selectedIndicatorCode;
  var _selectMonth;

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
  void initState() {
    getApTpList();
    super.initState();
  }

  void getApTpList() async {
    Tp tpApList = await _misService.getLisTp();
    listTp = tpApList.data!;
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading = false;
      setState(() {});
    });
  }

  void getIndicatorList(int? tpId) async {
    int tp = tpId ?? 0;
    Indicator indicator = await _misService.getIndicatorByTpId(tp);
    setState(() {
      indicatorList = indicator.data!;
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
        "Input MIS Data",
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
                                  labelText: 'Tp',
                                  errorStyle: const TextStyle(
                                      color: Colors.orange, fontSize: 16.0),
                                  hintText: 'Please select Tp',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  fillColor: Colors.orange),
                              isEmpty: _selectTp == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  validator: (value) {
                                    if (_selectTp == null ||
                                        _selectTp.isEmpty) {
                                      return 'Please enter Tp';
                                    }
                                    return null;
                                  },
                                  hint: const Text('Please select Tp'),
                                  value: _selectTp,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectTp = newValue;
                                      _selectedIndicatorCode != null
                                          ? _selectedIndicatorCode = null
                                          : null;
                                      getIndicatorList(
                                          int.parse(newValue.toString()));
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
                                    borderRadius: BorderRadius.circular(5.0)),
                                fillColor: Colors.orange),
                            isEmpty: _selectedIndicatorCode == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                validator: (value) {
                                  if (_selectedIndicatorCode == null ||
                                      _selectedIndicatorCode.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                hint:
                                    const Text('Please select indicator code'),
                                value: _selectedIndicatorCode,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedIndicatorCode = newValue;
                                  });
                                },
                                items: indicatorList.map((DataIndicator value) {
                                  return DropdownMenuItem<String>(
                                    value: value.code,
                                    child: Text("${value.code}"),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        }),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                labelText: 'Month',
                                errorStyle: const TextStyle(
                                    color: Colors.orange, fontSize: 16.0),
                                hintText: 'Please select month',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                fillColor: Colors.orange),
                            isEmpty: _selectMonth == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                validator: (value) {
                                  if (_selectMonth == null ||
                                      _selectMonth.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                hint:
                                    const Text('Please select month'),
                                value: _selectMonth,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectMonth = newValue;
                                  });
                                },
                                items: month.map((String month) {
                                  return DropdownMenuItem<String>(
                                    value: month,
                                    child: Text(month),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        }),
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
                              labelText: 'Target for month'),
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
                                actualAchieve.text = "0";
                                return;
                              }
                            } catch (e) {
                              actualAchieve.text = "0";
                            }
                          },
                          controller: actualAchieve,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Actual Achieve',
                              labelText: 'Actual Achieve'),
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
                                boyNumber.text = "0";
                                return;
                              }
                            } catch (e) {
                              boyNumber.text = "0";
                            }
                          },
                          controller: boyNumber,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Boy Number',
                              labelText: 'Boy Number'),
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
                                girlNumber.text = "0";
                                return;
                              }
                            } catch (e) {
                              girlNumber.text = "0";
                            }
                          },
                          controller: girlNumber,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Girl Number',
                              labelText: 'Girl Number'),
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
                                maleNumber.text = "0";
                                return;
                              }
                            } catch (e) {
                              maleNumber.text = "0";
                            }
                          },
                          controller: maleNumber,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Male Number',
                              labelText: 'Male Number'),
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
                                femaleNumber.text = "0";
                                return;
                              }
                            } catch (e) {
                              femaleNumber.text = "0";
                            }
                          },
                          controller: femaleNumber,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Female Number',
                              labelText: 'Female Number'),
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
                                mvc.text = "0";
                                return;
                              }
                            } catch (e) {
                              mvc.text = "0";
                            }
                          },
                          controller: mvc,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter MVC Number',
                              labelText: 'MVC Number'),
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
                                rc.text = "0";
                                return;
                              }
                            } catch (e) {
                              rc.text = "0";
                            }
                          },
                          controller: rc,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter RC Number',
                              labelText: 'RC Number'),
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
                                d1.text = "0";
                                return;
                              }
                            } catch (e) {
                              d1.text = "0";
                            }
                          },
                          controller: d1,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter D1 Number',
                              labelText: 'D1 Number'),
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
                                d2.text = "0";
                                return;
                              }
                            } catch (e) {
                              d2.text = "0";
                            }
                          },
                          controller: d2,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter D2 Number',
                              labelText: 'D2 Number'),
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
                                d3.text = "0";
                                return;
                              }
                            } catch (e) {
                              d3.text = "0";
                            }
                          },
                          controller: d3,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter D3 Number',
                              labelText: 'D3 Number'),
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
                                            _selectedIndicatorCode.toString(),
                                        "year":
                                            prefs.getInt(ConstantName().year),
                                        "target": targetNumber.text,
                                        "month": getMonth(_selectMonth),
                                        "actualAchieve": actualAchieve.text,
                                        "boyNumber": boyNumber.text,
                                        "girlNumber": girlNumber.text,
                                        "maleNumber": maleNumber.text,
                                        "femaleNumber": femaleNumber.text,
                                        "mvc": mvc.text,
                                        "rc": rc.text,
                                        "d1": d1.text,
                                        "d2": d2.text,
                                        "d3": d3.text
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
