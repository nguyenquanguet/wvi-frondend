import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vnmo_mis/model/ap_indicator.dart';
import 'package:vnmo_mis/model/indicator.dart';
import 'package:vnmo_mis/model/tp.dart';

import '../service/mis_service.dart';
import '../service/transaction_service.dart';

class MisController extends GetxController {
  final MisService _misService = MisService();

  var statusResponseDisplay = [].obs;
  var isLoading = true.obs;

  late ApMis apIndicator;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void dispose() {
    Get.delete<TransactionService>();
    super.dispose();
  }

  void getUsername() async {
    final prefs = await SharedPreferences.getInstance();
  }

  void getIndicatorList() async {
    Indicator indicator = await _misService.getApIndicator();
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  void getApMisDataList() async{
    ApMis apIndicator = await _misService.getMisByDateRange();
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  void getApTpList() async{
    Tp tpApList = await _misService.getAppTp();
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }
}
