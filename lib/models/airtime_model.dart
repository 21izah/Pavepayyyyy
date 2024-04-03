class AirtimeProviderModel {
  bool? success;
  String? message;
  List<Data>? data;

  AirtimeProviderModel({this.success, this.message, this.data});

  AirtimeProviderModel.fromJson(Map<String, dynamic> json) {
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
  String? provider;
  String? icon;
  int? minAmount;
  int? maxAmount;
  Plan? plan;

  Data(
      {this.name,
      this.provider,
      this.icon,
      this.minAmount,
      this.maxAmount,
      this.plan});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    provider = json['provider'];
    icon = json['icon'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['provider'] = this.provider;
    data['icon'] = this.icon;
    data['min_amount'] = this.minAmount;
    data['max_amount'] = this.maxAmount;
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    return data;
  }
}

class Plan {
  String? serviceType;
  String? shortname;
  int? billerId;
  int? productId;
  String? name;
  List<String>? plan;

  Plan(
      {this.serviceType,
      this.shortname,
      this.billerId,
      this.productId,
      this.name,
      this.plan});

  Plan.fromJson(Map<String, dynamic> json) {
    serviceType = json['service_type'];
    shortname = json['shortname'];
    billerId = json['biller_id'];
    productId = json['product_id'];
    name = json['name'];
    plan = json['plan'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_type'] = this.serviceType;
    data['shortname'] = this.shortname;
    data['biller_id'] = this.billerId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['plan'] = this.plan;
    return data;
  }
}
