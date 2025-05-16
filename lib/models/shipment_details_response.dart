class ShippingDetailsResponse {
  bool? success;
  String? message;
  OrderData? orderData;

  ShippingDetailsResponse({this.success, this.message, this.orderData});

  ShippingDetailsResponse.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? pickupLocation;
  String? deliveryLocation;
  String? vehicleType;
  String? labourType;
  String? courierType;
  String? orderId;
  String? weight;
  String? price;
  String? nameSender;
  String? mobileSender;
  String? zipSender;
  String? addressSender;
  String? officeSender;
  String? emailSender;
  String? nameReceiver;
  String? mobileReceiver;
  String? zipReceiver;
  String? addressReceiver;
  String? officeReceiver;
  String? emailReceiver;
  int? homeDelivery;
  String? orderTracking;
  int? overSized;
  int? fragileHandling;
  int? sameDayDelivery;
  int? caseOnDelivery;
  String? totalAmount;
  String? createdAt;
  String? updatedAt;

  OrderData(
      {this.id,
        this.userId,
        this.pickupLocation,
        this.deliveryLocation,
        this.vehicleType,
        this.labourType,
        this.courierType,
        this.orderId,
        this.weight,
        this.price,
        this.nameSender,
        this.mobileSender,
        this.zipSender,
        this.addressSender,
        this.officeSender,
        this.emailSender,
        this.nameReceiver,
        this.mobileReceiver,
        this.zipReceiver,
        this.addressReceiver,
        this.officeReceiver,
        this.emailReceiver,
        this.homeDelivery,
        this.orderTracking,
        this.overSized,
        this.fragileHandling,
        this.sameDayDelivery,
        this.caseOnDelivery,
        this.totalAmount,
        this.createdAt,
        this.updatedAt});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    pickupLocation = json['pickup_location'];
    deliveryLocation = json['delivery_location'];
    vehicleType = json['vehicle_type'];
    labourType = json['labour_type'];
    courierType = json['courier_type'];
    orderId = json['order_id'];
    weight = json['weight'];
    price = json['price'];
    nameSender = json['name_sender'];
    mobileSender = json['mobile_sender'];
    zipSender = json['zip_sender'];
    addressSender = json['address_sender'];
    officeSender = json['office_sender'];
    emailSender = json['email_sender'];
    nameReceiver = json['name_receiver'];
    mobileReceiver = json['mobile_receiver'];
    zipReceiver = json['zip_receiver'];
    addressReceiver = json['address_receiver'];
    officeReceiver = json['office_receiver'];
    emailReceiver = json['email_receiver'];
    homeDelivery = json['home_delivery'];
    orderTracking = json['order_tracking'];
    overSized = json['over_sized'];
    fragileHandling = json['fragile_handling'];
    sameDayDelivery = json['same_day_delivery'];
    caseOnDelivery = json['case_on_delivery'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['pickup_location'] = this.pickupLocation;
    data['delivery_location'] = this.deliveryLocation;
    data['vehicle_type'] = this.vehicleType;
    data['labour_type'] = this.labourType;
    data['courier_type'] = this.courierType;
    data['order_id'] = this.orderId;
    data['weight'] = this.weight;
    data['price'] = this.price;
    data['name_sender'] = this.nameSender;
    data['mobile_sender'] = this.mobileSender;
    data['zip_sender'] = this.zipSender;
    data['address_sender'] = this.addressSender;
    data['office_sender'] = this.officeSender;
    data['email_sender'] = this.emailSender;
    data['name_receiver'] = this.nameReceiver;
    data['mobile_receiver'] = this.mobileReceiver;
    data['zip_receiver'] = this.zipReceiver;
    data['address_receiver'] = this.addressReceiver;
    data['office_receiver'] = this.officeReceiver;
    data['email_receiver'] = this.emailReceiver;
    data['home_delivery'] = this.homeDelivery;
    data['order_tracking'] = this.orderTracking;
    data['over_sized'] = this.overSized;
    data['fragile_handling'] = this.fragileHandling;
    data['same_day_delivery'] = this.sameDayDelivery;
    data['case_on_delivery'] = this.caseOnDelivery;
    data['total_amount'] = this.totalAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

