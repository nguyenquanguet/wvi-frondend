import 'package:get/get.dart';
import 'package:vnmo_mis/model/ap_indicator.dart';
import 'package:vnmo_mis/model/indicator.dart';
import 'package:vnmo_mis/model/mis_data.dart';
import 'package:vnmo_mis/model/tp.dart';

import '../service/mis_service.dart';

class MisController extends GetxController {
  final MisService _misService = MisService();

  var misDataResponseDisplay = [].obs;
  var isLoading = true.obs;

  late ApMis apIndicator;

  @override
  void onInit() {
    getTransaction();
    super.onInit();
  }

  void getIndicatorList(int? tpId) async {
    int tp = tpId ?? 0;
    Indicator indicator = await _misService.getIndicatorByTpId(tp);
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  void getApMisDataList() async {
    ApMis apIndicator = await _misService.getMisByDateRange();
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  void getApTpList() async {
    Tp tpApList = await _misService.getLisTp();
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  void getTransaction() async {
    misDataResponseDisplay.value = [];
    isLoading.value = true;
    List<MisDataIndicator>? misDataResponse = await _misService.getMisData();
    misDataResponseDisplay.value = misDataResponse ??= [];
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }
}
