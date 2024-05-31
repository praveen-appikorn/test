
import 'dart:convert';

User demoFromJson(String str) => User.fromJson(json.decode(str));

String demoToJson(User data) => json.encode(data.toJson());

class User {
    String? firstName;
    String? secondName;
    String? age;
    List<dynamic>? friends;

    User({
        this.firstName,
        this.secondName,
        this.age,
        this.friends,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        secondName: json["secondName"],
        age: json["age"],
        friends: json["friends"] == null ? [] : List<dynamic>.from(json["friends"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "secondName": secondName,
        "age": age,
        "friends": friends == null ? [] : List<dynamic>.from(friends!.map((x) => x)),
    };
}
