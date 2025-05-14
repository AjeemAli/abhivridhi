class OrderDetailsModel {
  bool? success;
  String? message;
  OrderData? orderData;

  OrderDetailsModel({this.success, this.message, this.orderData});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    orderData = json['orderData'] != null
        ? new OrderData.fromJson(json['orderData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.orderData != null) {
      data['orderData'] = this.orderData!.toJson();
    }
    return data;
  }
}

class OrderData {
  int? id;
  String? name;
  int? userId;
  int? newDriverId;
  String? price;
  DateTime? date;
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

  OrderData(
      {this.id,
        this.name,
        this.userId,
        this.newDriverId,
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

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    newDriverId = json['new_Driver_id'];
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
    data['new_Driver_id'] = this.newDriverId;
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
