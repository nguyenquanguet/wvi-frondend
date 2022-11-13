
class ApiPath {

  static const String basePath = "http://202.151.162.220:8088/api/";
  // static const String basePath = "http://10.0.2.2:8088/api/";


  static const String loginPath = "${basePath}auth/";

  static const String apMisPath = "${basePath}mis/find-all-mis/";

  static const String indicatorListPath = "${basePath}mis/find-all-indicator-by-tp-id/";

  static const String tpList = "${basePath}mis/find-all-tp/";

  static const String createData = "${basePath}mis/create-data";

}
