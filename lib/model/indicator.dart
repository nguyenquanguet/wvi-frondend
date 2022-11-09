class Indicator {
  int? result;
  String? code;
  String? message;
  List<DataIndicator>? data;

  Indicator({this.result, this.code, this.message, this.data});

  Indicator.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataIndicator>[];
      json['data'].forEach((v) {
        data!.add(DataIndicator.fromJson(v));
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

class DataIndicator {
  int? id;
  String? code;
  String? description;
  String? note;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  DataIndicator(
      {this.id,
        this.code,
        this.description,
        this.note,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  DataIndicator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    note = json['note'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['description'] = description;
    data['note'] = note;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    return data;
  }
}