import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnmo_mis/model/ap_indicator.dart';
import 'package:vnmo_mis/model/indicator.dart';
import 'package:vnmo_mis/model/mis_data.dart';
import 'package:vnmo_mis/model/tp.dart';
import 'package:vnmo_mis/service/storage/constant_name.dart';

import '../widgets/snackbars.dart';
import 'api/api_path.dart';

class MisService {

  final String serverError = "Connect to Server Error !";

  Future<ApMis> getMisByDateRange(
      {int? tpId, int? indicatorId, int? year, int? month}) async {
    SharedPreferences data = await SharedPreferences.getInstance();
    final response = await get(
        Uri.parse('${ApiPath.apMisPath}${data.getInt(ConstantName().apId)}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Language': 'en'
        }).catchError((onError) {
      const SnackBars().snackBarFail(serverError, "Get Mis Data");
    });

    if (response.statusCode == 200) {
      return ApMis.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception(serverError);
    }
  }
  
  Future<Indicator> getIndicatorByTpId(int tpId) async {
    final response = await get(
      Uri.parse("${ApiPath.indicatorListPath}$tpId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': "en",
      },
    ).catchError((onError) {
      const SnackBars().snackBarFail(serverError, "indicator");
    });

    if (response.statusCode == 200) {
      return Indicator.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception(serverError);
    }
  }

  Future<Tp> getLisTp() async {
    final response = await get(
      Uri.parse(ApiPath.tpList),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': "en",
      },
    ).catchError((onError) {
      const SnackBars().snackBarFail(serverError, "tp");
    });
    if (response.statusCode == 200) {
      return Tp.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception(serverError);
    }
  }

  Future createData(dynamic jsons) async {
    final response = await post(
      Uri.parse(ApiPath.createData),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(jsons),
    ).catchError((onError) {
      const SnackBars().snackBarFail("Error", "");
    });
    if (response.statusCode == 200) {
      return 200;
    } else {
      throw Exception(serverError);
    }
  }

  Future getMisData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? apId = pref.getInt(ConstantName().apId);
    final response = await get(
      Uri.parse("${ApiPath.apMisPath}$apId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': "en",
      },
    ).catchError((onError) {
      const SnackBars().snackBarFail(serverError, "get mis data");
    });
    if (response.statusCode == 200) {
      MisData misData = MisData.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return misData.data;
    } else {
      throw Exception(serverError);
    }
  }
}
