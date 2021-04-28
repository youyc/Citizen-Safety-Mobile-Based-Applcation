class Message {
  int id;
  String title;
  String content;

  Message(int id, String title, String content) {
    this.id = id;
    this.title = title;
    this.content = content;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  Message.fromMap(Map<String, Object> map) {
    id = map["ID"]; //map["..."] must follow the name in database table
    title = map["TITLE"];
    content = map["CONTENT"];
  }
}
