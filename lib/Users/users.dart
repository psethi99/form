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
      'dateTime': dateTime,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    //if (map == null) return null;

    return User(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      mobileNumber: map['mobile_number'],
      email: map['email'],
      dateTime: map['dateTime'],
    );
  }
}
