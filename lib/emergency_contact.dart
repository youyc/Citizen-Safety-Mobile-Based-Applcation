class Emergency_Contact {
  int id;
  String username;
  String name;
  String phone_number;
  String relationship;

  Emergency_Contact(int id, String username, String name, String phone_number,
      String relationship) {
    this.id = id;
    this.username = username;
    this.name = name;
    this.phone_number = phone_number;
    this.relationship = relationship;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'phone_number': phone_number,
      'relationship': relationship,
    };
  }

  Emergency_Contact.fromMap(Map<String, Object> map) {
    id = map["ID"]; //map["..."] must follow the name in database table
    username = map["USERNAME"];
    name = map["NAME"];
    phone_number = map["PHONE"];
    relationship = map["RELATIONSHIP"];
  }
}
