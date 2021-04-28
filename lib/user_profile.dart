class UserProfile {
  int id;
  String name;
  String gender;
  String identification_photo;
  String identification_type;
  String identification_number;
  String phone_number;
  String email;

  UserProfile(
    int id,
    String name,
    String gender,
    String identification_photo,
    String identification_type,
    String identification_number,
    String phone_number,
    String email,
    //List<Emergency_Contact> contact_list,
  ) {
    this.id = id;
    this.name = name;
    this.gender = gender;
    this.identification_photo = identification_photo;
    this.identification_type = identification_type;
    this.identification_number = identification_number;
    this.phone_number = phone_number;
    this.email = email;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'identification_photo': identification_photo,
      'identification_type': identification_type,
      'identification_number': identification_number,
      'phone_number': phone_number,
      'email': email,
    };
  }

  UserProfile.fromMap(Map<String, Object> map) {
    id = map["ID"];
    name = map["NAME"];
    gender = map['GENDER'];
    identification_photo = map['IDENTIFICATIONPHOTO'];
    identification_type = map['IDENTIFICATIONTYPE'];
    identification_number = map['IDENTIFICATIONNUMBER'];
    phone_number = map['PHONE'];
    email = map['EMAIL'];
  }
}
