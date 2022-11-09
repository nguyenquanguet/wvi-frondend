class LoginResponse {
  int? result;
  String? code;
  String? message;
  Data? data;

  LoginResponse({this.result, this.code, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? username;
  String? email;
  int? userApId;
  String? userApName;

  Data(
      {this.userId, this.username, this.email, this.userApId, this.userApName});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    email = json['email'];
    userApId = json['userApId'];
    userApName = json['userApName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['username'] = username;
    data['email'] = email;
    data['userApId'] = userApId;
    data['userApName'] = userApName;
    return data;
  }
}