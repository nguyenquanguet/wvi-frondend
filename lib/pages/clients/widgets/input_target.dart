import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnmo_mis/controllers/mis_controller.dart';
import 'package:vnmo_mis/model/indicator.dart';
import 'package:vnmo_mis/model/tp.dart';
import 'package:vnmo_mis/pages/clients/widgets/review_input_target.dart';
import 'package:vnmo_mis/service/mis_service.dart';

import '../../../helpers/responsiveness.dart';
import '../../../service/storage/constant_name.dart';

class InputTarget extends StatefulWidget {
  const InputTarget({Key? key}) : super(key: key);

  @override
  _TargetData createState() => _TargetData();
}

class _TargetData extends State<InputTarget> {
  final MisService _misService = MisService();

  final MisController counterController = Get.put(MisController());

  final targetNumber = TextEditingController()..text = "0";

  final _formKey = GlobalKey<FormState>();

  bool isLoading = true;

  List<DataTp> listTp = [];
  List<DataIndicator> indicatorList = [];

  var _selectTp;
  var _selectedIndicatorCode;
  String? _selectTpName;
  int? selectTargetNumber;

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

  void getTpName(int tpId) async{
    for(int i = 0; i< listTp.length; i++){
      if(tpId == listTp.elementAt(i).id){
        _selectTpName = listTp.elementAt(i).name;
      }
    }
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
        "Input Target MIS",
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
                                      getTpName(int.parse(newValue.toString()));
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
                                    color: Colors.orange, fontSize: 10.0),
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
                                    child: Text(
                                        "${value.code}: ${value.description}"),
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
                          enabled: true,
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
                            selectTargetNumber = int.parse(value);
                          },
                          controller: targetNumber,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Target Indicator',
                              labelText: 'Target for month'),
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

                                    prefs.setString(ConstantName().selectTpName, _selectTpName.toString());
                                    prefs.setString(ConstantName().selectIndicatorCode, _selectedIndicatorCode);
                                    prefs.setInt(ConstantName().selectTargetId, selectTargetNumber!);

                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return const ReviewInputTarget();
                                        });
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
