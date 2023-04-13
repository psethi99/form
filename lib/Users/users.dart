import 'dart:ffi';

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  DateTime? dateTime;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'mobile_number': mobileNumber,
      'email': email,
      'created_at': dateTime?.toIso8601String(),
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    //if (map == null) return null;

    return User(
      id: map['id'] as int?,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      mobileNumber: map['mobile_number'] as String,
      email: map['email'] as String,
      dateTime: DateTime.parse(map['date_time'] as String)
    );
  }
}
