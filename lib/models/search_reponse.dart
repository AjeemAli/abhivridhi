class SearchResponse {
  bool? status;
  String? message;
  SearchData? searchData;

  SearchResponse({this.status, this.message, this.searchData});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    searchData = json['searchData'] != null
        ? new SearchData.fromJson(json['searchData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.searchData != null) {
      data['searchData'] = this.searchData!.toJson();
    }
    return data;
  }
}

class SearchData {
  int? id;
  String? name;
  int? userId;
  String? price;
  String? date;
  String? startLocation;
  String? endLocation;
  String? weight;
  String? address;
  String? phone;
  String? email;
  String? zipCode;
  String? productName;
  String? type;
  String? oversizeCharge;
  String? orderId;
  String? status;
  String? progress;
  String? createdAt;
  String? updatedAt;
  String? nextDayDeliveryCharge;
  String? trackingCharge;

  SearchData(
      {this.id,
        this.name,
        this.userId,
        this.price,
        this.date,
        this.startLocation,
        this.endLocation,
        this.weight,
        this.address,
        this.phone,
        this.email,
        this.zipCode,
        this.productName,
        this.type,
        this.oversizeCharge,
        this.orderId,
        this.status,
        this.progress,
        this.createdAt,
        this.updatedAt,
        this.nextDayDeliveryCharge,
        this.trackingCharge});

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    price = json['price'];
    date = json['date'];
    startLocation = json['start_location'];
    endLocation = json['end_location'];
    weight = json['weight'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    zipCode = json['Zip_code'];
    productName = json['product_name'];
    type = json['type'];
    oversizeCharge = json['Oversize_charge'];
    orderId = json['order_id'];
    status = json['status'];
    progress = json['progress'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nextDayDeliveryCharge = json['next_day_delivery_charge'];
    trackingCharge = json['tracking_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['price'] = this.price;
    data['date'] = this.date;
    data['start_location'] = this.startLocation;
    data['end_location'] = this.endLocation;
    data['weight'] = this.weight;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['Zip_code'] = this.zipCode;
    data['product_name'] = this.productName;
    data['type'] = this.type;
    data['Oversize_charge'] = this.oversizeCharge;
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    data['progress'] = this.progress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['next_day_delivery_charge'] = this.nextDayDeliveryCharge;
    data['tracking_charge'] = this.trackingCharge;
    return data;
  }
}

