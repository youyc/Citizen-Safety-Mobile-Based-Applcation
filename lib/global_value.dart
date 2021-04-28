import 'package:project1/user_account.dart';

import 'message.dart';
import 'emergency_contact.dart';
import 'alarm.dart';
import 'dart:io';

class GlobalState {
  //navigation bar control
  int navigation_bar_index = 0;
  //message edit or add new item control
  int message_control_index = 0; //0 = add new message //1 = edit message
  int message_selected_index;
  int quick_action_index; //control quick action
  int language_index; //0 = english // 1 = malay

  //location and address control
  String latitude = null;
  String longitude = null;
  //only 1 user
  String password = null;
  Directory directory = null;
  File photo = null;
  List user_list = [];
  List<UserAccount> user_list_local = [];
  List<Message> message_list = [];
  List<Emergency_Contact> emergency_contact_list = [];
  List<Alarm> alarm_list = [];

  static GlobalState instance = GlobalState._();
  GlobalState._();
}
