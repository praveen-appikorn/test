// To parse this JSON data, do
//
//     final demo = demoFromJson(jsonString);

import 'dart:convert';

User demoFromJson(String str) => User.fromJson(json.decode(str));

String demoToJson(User data) => json.encode(data.toJson());

class User {
  String? firstName;
  String? secondName;
  String? make;
  List<dynamic>? friends;

  User({
    this.firstName,
    this.secondName,
    this.make,
    this.friends,
  });

// custom copywith
  User copyWith(User user) => User(
        firstName: user.firstName ?? firstName,
        secondName: user.secondName ?? secondName,
        make: user.make ?? make,
        friends: user.friends ?? friends,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        secondName: json["secondName"],
        make: json["make"],
        friends: json["friends"] == null
            ? []
            : List<dynamic>.from(json["friends"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "secondName": secondName,
        "make": make,
        "friends":
            friends == null ? [] : List<dynamic>.from(friends!.map((x) => x)),
      };
}
