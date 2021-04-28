class UserAccount {
  int id;
  String username;
  String password;
  String phone_number;
  String email;
  String name;
  String gender;
  String identification_type;
  String identification_number;
  String identification_photo;

  User(
    int id,
    String username,
    String password,
    String phone_number,
    String email,
    String name,
    String gender,
    String identification_type,
    String identification_number,
    String identification_photo,
  ) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.phone_number = phone_number;
    this.email = email;
    this.name = name;
    this.gender = gender;
    this.identification_type = identification_type;
    this.identification_number = identification_number;
    this.identification_photo = identification_photo;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'phone_number': phone_number,
      'email': email,
      'name': name,
      'gender': gender,
      'identification_type': identification_type,
      'identification_number': identification_number,
      'identification_photo': identification_photo,
    };
  }

  UserAccount.fromMap(Map<String, Object> map) {
    id = map["ID"];
    username = map["USERNAME"];
    password = map["PASSWORD"];
    phone_number = map['PHONE'];
    email = map['EMAIL'];
    name = map["NAME"];
    gender = map['GENDER'];
    identification_type = map['IDTYPE'];
    identification_number = map['IDNUMBER'];
    identification_photo = map['IDPHOTO'];
  }

  // UserAccount.fromHTTPJason(Map<String, Object> map) {
  //   id = map["ID"];
  //   username = map["username"];
  //   password = map["PASSWORD"];
  //   phone_number = map['PHONE'];
  //   email = map['EMAIL'];
  //   name = map["NAME"];
  //   gender = map['GENDER'];
  //   identification_photo = map['IDENTIFICATIONPHOTO'];
  //   identification_type = map['IDENTIFICATIONTYPE'];
  //   identification_number = map['IDENTIFICATIONNUMBER'];
  // }
}
