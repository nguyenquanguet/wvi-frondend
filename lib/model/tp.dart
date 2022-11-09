class Tp {
  int? result;
  String? code;
  String? message;
  List<DataTp>? data;

  Tp({this.result, this.code, this.message, this.data});

  Tp.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataTp>[];
      json['data'].forEach((v) {
        data!.add(DataTp.fromJson(v));
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

class DataTp {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;

  DataTp(
      {this.id,
        this.name,
        this.description,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy});

  DataTp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    return data;
  }
}