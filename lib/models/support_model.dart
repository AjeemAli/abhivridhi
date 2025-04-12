class SupportResponse {
  int? id;
  String? email;
  String? contactNo;
  String? messages;
  String? updatedAt;
  String? createdAt;

  SupportResponse(
      {this.id,
        this.email,
        this.contactNo,
        this.messages,
        this.updatedAt,
        this.createdAt});

  SupportResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    contactNo = json['contact_no'];
    messages = json['messages'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['messages'] = this.messages;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
