class Alarm {
  String username;
  String alarm_name;

  Alarm(String username, String alarm_name) {
    this.username = username;
    this.alarm_name = alarm_name;
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'alarm_name': alarm_name,
    };
  }

  Alarm.fromMap(Map<String, Object> map) {
    username = map["USERNAME"];
    alarm_name =
        map["ALARMNAME"]; //map["..."] must follow the name in database table
  }
}
