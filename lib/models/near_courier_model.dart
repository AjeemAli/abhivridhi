  class NearPlaceCourierModel {
    String? message;
    List<Data>? data;

    NearPlaceCourierModel({this.message, this.data});

    NearPlaceCourierModel.fromJson(Map<String, dynamic> json) {
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
      data['message'] = this.message;
      if (this.data != null) {
        data['data'] = this.data!.map((v) => v.toJson()).toList();
      }
      return data;
    }
  }

  class Data {
    int? id;
    String? storeName;
    String? storeAddress;
    String? latitude;
    String? longitude;
    String? contactNumber;
    String? email;
    String? openingHours;
    String? servicesOffered;
    String? storeType;
    int? status;
    double? distance;

    Data(
        {this.id,
          this.storeName,
          this.storeAddress,
          this.latitude,
          this.longitude,
          this.contactNumber,
          this.email,
          this.openingHours,
          this.servicesOffered,
          this.storeType,
          this.status,
          this.distance});

    Data.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      storeName = json['store_name'];
      storeAddress = json['store_address'];
      latitude = json['latitude'];
      longitude = json['longitude'];
      contactNumber = json['contact_number'];
      email = json['email'];
      openingHours = json['opening_hours'];
      servicesOffered = json['services_offered'];
      storeType = json['store_type'];
      status = json['status'];
      distance = json['distance'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['store_name'] = this.storeName;
      data['store_address'] = this.storeAddress;
      data['latitude'] = this.latitude;
      data['longitude'] = this.longitude;
      data['contact_number'] = this.contactNumber;
      data['email'] = this.email;
      data['opening_hours'] = this.openingHours;
      data['services_offered'] = this.servicesOffered;
      data['store_type'] = this.storeType;
      data['status'] = this.status;
      data['distance'] = this.distance;
      return data;
    }
  }
