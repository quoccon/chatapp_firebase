class UserAuth {
  UserAuth({
    required this.status,
    required this.msg,
    required this.infoU,
  });

  final int? status;
  final String? msg;
  final InfoU? infoU;

  factory UserAuth.fromJson(Map<String, dynamic> json){
    return UserAuth(
      status: json["status"],
      msg: json["msg"],
      infoU: json["infoU"] == null ? null : InfoU.fromJson(json["infoU"]),
    );
  }

}

class InfoU {
  InfoU({
    required this.id,
    required this.username,
    required this.password,
    required this.v,
    required this.image,
  });

  final String? id;
  final String? username;
  final String? password;
  final int? v;
  final String? image;

  factory InfoU.fromJson(Map<String, dynamic> json){
    return InfoU(
      id: json["_id"],
      username: json["username"],
      password: json["password"],
      v: json["__v"],
      image: json["image"],
    );
  }

}
