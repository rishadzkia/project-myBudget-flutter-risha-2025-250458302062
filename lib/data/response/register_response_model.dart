import 'dart:convert';

class RegisterResponsetModel {
    final String? message;
    final User? user;
    final String? token;

    RegisterResponsetModel({
        this.message,
        this.user,
        this.token,
    });

    factory RegisterResponsetModel.fromJson(String str) => RegisterResponsetModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RegisterResponsetModel.fromMap(Map<String, dynamic> json) => RegisterResponsetModel(
        message: json["message"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "user": user?.toMap(),
        "token": token,
    };
}

class User {
    final String? name;
    final String? email;
    final String? updatedAt;
    final String? createdAt;
    final int? id;

    User({
        this.name,
        this.email,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
    };
}
