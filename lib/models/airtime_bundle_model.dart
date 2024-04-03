class AirtimeBundleModel {
  bool? success;
  String? message;
  List<Data>? data;

  AirtimeBundleModel({this.success, this.message, this.data});

  AirtimeBundleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? allowance;
  int? price;
  String? validity;
  dynamic datacode;

  Data({this.name, this.allowance, this.price, this.validity, this.datacode});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    allowance = json['allowance'];
    price = json['price'];
    validity = json['validity'];
    datacode = json['datacode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['allowance'] = this.allowance;
    data['price'] = this.price;
    data['validity'] = this.validity;
    data['datacode'] = this.datacode;
    return data;
  }
}
