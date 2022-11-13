class MisData {
  int? result;
  String? code;
  String? message;
  List<MisDataIndicator>? data;

  MisData({this.result, this.code, this.message, this.data});

  MisData.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MisDataIndicator>[];
      json['data'].forEach((v) {
        data!.add(MisDataIndicator.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MisDataIndicator {
  int? id;
  int? apId;
  String? indicatorCode;
  int? unitId;
  int? year;
  int? month;
  int? target;
  int? targetType;
  int? actualAchieve;
  int? boyNumber;
  int? girlNumber;
  int? maleNumber;
  int? femaleNumber;
  int? mvc;
  int? rc;
  int? d1;
  int? d2;
  int? d3;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  MisDataIndicator(
      {this.id,
        this.apId,
        this.indicatorCode,
        this.unitId,
        this.year,
        this.month,
        this.target,
        this.targetType,
        this.actualAchieve,
        this.boyNumber,
        this.girlNumber,
        this.maleNumber,
        this.femaleNumber,
        this.mvc,
        this.rc,
        this.d1,
        this.d2,
        this.d3,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  MisDataIndicator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    apId = json['apId'];
    indicatorCode = json['indicatorCode'];
    unitId = json['unitId'];
    year = json['year'];
    month = json['month'];
    target = json['target'];
    targetType = json['targetType'];
    actualAchieve = json['actualAchieve'];
    boyNumber = json['boyNumber'];
    girlNumber = json['girlNumber'];
    maleNumber = json['maleNumber'];
    femaleNumber = json['femaleNumber'];
    mvc = json['mvc'];
    rc = json['rc'];
    d1 = json['d1'];
    d2 = json['d2'];
    d3 = json['d3'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['apId'] = apId;
    data['indicatorCode'] = indicatorCode;
    data['unitId'] = unitId;
    data['year'] = year;
    data['month'] = month;
    data['target'] = target;
    data['targetType'] = targetType;
    data['actualAchieve'] = actualAchieve;
    data['boyNumber'] = boyNumber;
    data['girlNumber'] = girlNumber;
    data['maleNumber'] = maleNumber;
    data['femaleNumber'] = femaleNumber;
    data['mvc'] = mvc;
    data['rc'] = rc;
    data['d1'] = d1;
    data['d2'] = d2;
    data['d3'] = d3;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    return data;
  }
}