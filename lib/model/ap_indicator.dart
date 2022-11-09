class ApMis {
  int? result;
  String? code;
  String? message;
  List<Data>? data;

  ApMis({this.result, this.code, this.message, this.data});

  ApMis.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  int? apId;
  int? indicatorId;
  String? indicatorCode;
  int? year;
  int? month;
  int? target;
  int? actualAchieve;
  int? boyNumber;
  int? girlNumber;
  int? maleNumber;
  int? femaleNumber;
  int? mvc;
  int? rc;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  Data(
      {this.id,
        this.apId,
        this.indicatorId,
        this.indicatorCode,
        this.year,
        this.month,
        this.target,
        this.actualAchieve,
        this.boyNumber,
        this.girlNumber,
        this.maleNumber,
        this.femaleNumber,
        this.mvc,
        this.rc,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    apId = json['apId'];
    indicatorId = json['indicatorId'];
    indicatorCode = json['indicatorCode'];
    year = json['year'];
    month = json['month'];
    target = json['target'];
    actualAchieve = json['actualAchieve'];
    boyNumber = json['boyNumber'];
    girlNumber = json['girlNumber'];
    maleNumber = json['maleNumber'];
    femaleNumber = json['femaleNumber'];
    mvc = json['mvc'];
    rc = json['rc'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['apId'] = apId;
    data['indicatorId'] = indicatorId;
    data['indicatorCode'] = indicatorCode;
    data['year'] = year;
    data['month'] = month;
    data['target'] = target;
    data['actualAchieve'] = actualAchieve;
    data['boyNumber'] = boyNumber;
    data['girlNumber'] = girlNumber;
    data['maleNumber'] = maleNumber;
    data['femaleNumber'] = femaleNumber;
    data['mvc'] = mvc;
    data['rc'] = rc;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    return data;
  }
}