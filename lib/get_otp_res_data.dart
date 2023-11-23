/// details : {"id":18,"user_id":52,"email":"janaki.vinsup@gmail.com","otp":"W9BOfZ","created_at":"2023-11-10T06:40:03.000000Z","updated_at":"2023-11-16T09:37:08.000000Z"}
/// status : "OTP Valid"

class GetOtpResData {
  GetOtpResData({
    this.details,
    this.status,
  });

  GetOtpResData.fromJson(dynamic json) {
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    status = json['status'];
  }
  Details? details;
  String? status;
  GetOtpResData copyWith({
    Details? details,
    String? status,
  }) =>
      GetOtpResData(
        details: details ?? this.details,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (details != null) {
      map['details'] = details?.toJson();
    }
    map['status'] = status;
    return map;
  }
}

/// id : 18
/// user_id : 52
/// email : "janaki.vinsup@gmail.com"
/// otp : "W9BOfZ"
/// created_at : "2023-11-10T06:40:03.000000Z"
/// updated_at : "2023-11-16T09:37:08.000000Z"

class Details {
  Details({
    this.id,
    this.userId,
    this.email,
    this.otp,
    this.createdAt,
    this.updatedAt,
  });

  Details.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    email = json['email'];
    otp = json['otp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  num? userId;
  String? email;
  String? otp;
  String? createdAt;
  String? updatedAt;
  Details copyWith({
    num? id,
    num? userId,
    String? email,
    String? otp,
    String? createdAt,
    String? updatedAt,
  }) =>
      Details(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        email: email ?? this.email,
        otp: otp ?? this.otp,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['email'] = email;
    map['otp'] = otp;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
