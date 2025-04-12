class TrackingHistoryResponse {
  bool? status;
  String? message;
  List<HistoryData>? historyData;

  TrackingHistoryResponse({this.status, this.message, this.historyData});

  TrackingHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['historyData'] != null) {
      historyData = <HistoryData>[];
      json['historyData'].forEach((v) {
        historyData!.add(new HistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.historyData != null) {
      data['historyData'] = this.historyData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryData {
  int? id;
  int? userId;
  String? orderId;
  String? searchedAt;

  HistoryData({this.id, this.userId, this.orderId, this.searchedAt});

  HistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    searchedAt = json['searched_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_id'] = this.orderId;
    data['searched_at'] = this.searchedAt;
    return data;
  }
}
