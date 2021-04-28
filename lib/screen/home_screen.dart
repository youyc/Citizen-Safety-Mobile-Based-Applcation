import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project1/global_value.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'dart:io'; //for File variable
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../database.dart';
import 'package:just_audio/just_audio.dart';

// import 'package:file_picker/file_picker.dart';

class Home_Screen extends StatefulWidget {
  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  TextEditingController _confirm_controller = TextEditingController();
  GlobalState _global_key = GlobalState.instance;
  DB _db = DB.instance;

  //confirmation dialog
  // Future<bool> _confirm_proceed() async {
  //   bool proceed = false;

  //   return proceed;
  // }

  void _show_confirmation_dialog(String function) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          titlePadding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text(
            "Confirmation",
            style: TextStyle(fontSize: 25),
          ),
          children: [
            Divider(
              color: Colors.black,
            ),
            Text(
              "Do you want to proceed this action?\nIf yes, enter 123 and press Yes Button",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: _confirm_controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Example: 123',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      //for dialog
                      String value = _confirm_controller.text;
                      if (value == "123") {
                        Navigator.of(context).pop();
                        _confirm_controller.clear();
                        if (function == "call1") {
                          _makePhoneCall("tel:0163361109");
                        } else if (function == "call2") {
                          _makePhoneCall("tel:01155025309");
                        } else if (function == "call3") {
                          _makePhoneCall("tel:0124721109");
                        } else if (function == "call4") {
                          _makePhoneCall("tel:045388639");
                        }
                      } else {
                        _confirm_controller.clear();
                        Toast.show(
                          "Wrong Input",
                          context,
                          duration: 4,
                          gravity: Toast.BOTTOM,
                        );
                      }
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _show_usermanual() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 5),
          backgroundColor: Colors.grey[100],
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "User Manual",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              width: 150,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_instant_message();
                },
                child: Text(
                  "instant_message".tr().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_instant_call();
                },
                child: Text(
                  "instant_call".tr().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_scream_alarm();
                },
                child: Text(
                  "scream_alarm".tr().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_location();
                },
                child: Text(
                  "location".tr().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_account();
                },
                child: Text(
                  "account".tr().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show_instant_message() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.orange[50],
          titlePadding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text("instant_message".tr().toString()),
          children: [
            Divider(
              color: Colors.black,
            ),
            Text("description".tr().toString()),
            Text(
              "instant_message_desription".tr().toString(),
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: Colors.black,
            ),
            Text("function".tr().toString()),
            Text("send_emergency_message".tr().toString()),
            Text("send_emergency_message1".tr().toString()),
            Text("send_emergency_message2".tr().toString()),
            Text("send_emergency_message3".tr().toString()),
            Text("send_emergency_message4".tr().toString()),
            Text("add_emergency_message".tr().toString()),
            Text("add_emergency_message1".tr().toString()),
            Text("add_emergency_message2".tr().toString()),
            Text("add_emergency_message3".tr().toString()),
            Text("add_emergency_message4".tr().toString()),
            Text("edit_emergency_message".tr().toString()),
            Text("edit_emergency_message1".tr().toString()),
            Text("edit_emergency_message2".tr().toString()),
            Text("edit_emergency_message3".tr().toString()),
            Text("delete_emergency_message".tr().toString()),
            Text("delete_emergency_message1".tr().toString()),
            Text("delete_emergency_message2".tr().toString()),
            Text("delete_emergency_message3".tr().toString()),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show_instant_call() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.orange[50],
          titlePadding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text("Instant Call"),
          children: [
            Divider(
              color: Colors.black,
            ),
            Text("description".tr().toString()),
            Text(
              "instant_call_desription".tr().toString(),
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: Colors.black,
            ),
            Text("function".tr().toString()),
            Text("make_instant_call".tr().toString()),
            Text("make_instant_call1".tr().toString()),
            Text("make_instant_call2".tr().toString()),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show_scream_alarm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.orange[50],
          titlePadding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text("Scream Alarm"),
          children: [
            Divider(
              color: Colors.black,
            ),
            Text("description".tr().toString()),
            Text(
              "scream_alarm_desription".tr().toString(),
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: Colors.black,
            ),
            Text("function".tr().toString()),
            Text("make_scream_alarm".tr().toString()),
            Text("make_scream_alarm1".tr().toString()),
            Text("make_scream_alarm2".tr().toString()),
            Text("add_scream_alarm".tr().toString()),
            Text("add_scream_alarm1".tr().toString()),
            Text("add_scream_alarm2".tr().toString()),
            Text("delete_scream_alarm".tr().toString()),
            Text("delete_scream_alarm1".tr().toString()),
            Text("delete_scream_alarm2".tr().toString()),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show_location() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.orange[50],
          titlePadding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text("Location"),
          children: [
            Divider(
              color: Colors.black,
            ),
            Text("Description:"),
            Text(
              "Location allows citizen to share live location with friends and family members when citizen wants to have safety control or during emergency.",
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: Colors.black,
            ),
            Text("Functions: "),
            Text("1. View Location of yourself"),
            Text("- Move to Location Screen"),
            Text("- View the address and map\n"),
            Text("2. Share Live Location"),
            Text("- Move to Location Screen"),
            Text("- Press Share Live Location Button"),
            Text("- Select Sharing Targets"),
            Text("- Press Share Button"),
            Text("- Enter 123 and press Yes Button\n"),
            Text("3. View Live Location of freinds or family members"),
            Text("- Move to Location Screen"),
            Text("- Press View Live Location of Others Button"),
            Text("- View the address and map"),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _show_account() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.orange[50],
          titlePadding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text("Account"),
          children: [
            Divider(
              color: Colors.black,
            ),
            Text("description".tr().toString()),
            Text(
              "account_desription".tr().toString(),
              textAlign: TextAlign.justify,
            ),
            Divider(
              color: Colors.black,
            ),
            Text("function".tr().toString()),
            Text("edit_personal_information".tr().toString()),
            Text("edit_personal_information1".tr().toString()),
            Text("edit_personal_information2".tr().toString()),
            Text("edit_personal_information3".tr().toString()),
            Text("edit_personal_information4".tr().toString()),
            Text("edit_emergency_contact_information".tr().toString()),
            Text("edit_emergency_contact_information1".tr().toString()),
            Text("edit_emergency_contact_information2".tr().toString()),
            Text("edit_emergency_contact_information3".tr().toString()),
            Text("edit_emergency_contact_information4".tr().toString()),
            Text("add_emergency_contact_information".tr().toString()),
            Text("add_emergency_contact_information1".tr().toString()),
            Text("add_emergency_contact_information2".tr().toString()),
            Text("add_emergency_contact_information3".tr().toString()),
            Text("add_emergency_contact_information4".tr().toString()),
            Text("delete_emergency_contact_information".tr().toString()),
            Text("delete_emergency_contact_information1".tr().toString()),
            Text("delete_emergency_contact_information2".tr().toString()),
            Text("delete_emergency_contact_information3".tr().toString()),
            Text("backup_information".tr().toString()),
            Text("backup_information1".tr().toString()),
            Text("backup_information2".tr().toString()),
            Text("backup_information3".tr().toString()),
            Text("log_out_account".tr().toString()),
            Text("log_out_account1".tr().toString()),
            Text("log_out_account2".tr().toString()),
            Text("log_out_account3".tr().toString()),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Okay",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //instant message functions
  void _show_instant_message_functions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 5),
          backgroundColor: Colors.grey[100],
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "instant_message".tr().toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  _global_key.message_control_index = 0;
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/AddEmergencyMessageScreen");
                },
                child: Text(
                  "add_instant_message".tr().toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            _global_key.message_list.length != 0
                ? Container(
                    constraints:
                        BoxConstraints(minWidth: 0, maxWidth: double.maxFinite),
                    width: double.maxFinite,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        itemCount: _global_key.message_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 200,
                            child: RaisedButton(
                              elevation: 5,
                              onPressed: () {
                                _global_key.message_control_index = 1;
                                _global_key.message_selected_index = index;
                                Navigator.of(context).pop();
                                Navigator.of(context)
                                    .pushNamed("/AddEmergencyMessageScreen");
                              },
                              child: Text(
                                "${_global_key.message_list[index].title}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : Text(
                    "Please add emergency message",
                    textAlign: TextAlign.center,
                  ),
          ],
        );
      },
    );
  }

  //instant call functions
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _show_instant_call_receivers() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 5),
          backgroundColor: Colors.grey[100],
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "instant_call".tr().toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            _global_key.emergency_contact_list.length != 0
                ? Container(
                    constraints:
                        BoxConstraints(minWidth: 0, maxWidth: double.maxFinite),
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      itemCount: _global_key.emergency_contact_list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RaisedButton(
                          elevation: 5,
                          onPressed: () async {
                            Navigator.of(context).pop();
                            // _show_confirmation_dialog("call1");
                            _makePhoneCall(
                                "tel:${_global_key.emergency_contact_list[index].phone_number}");
                          },
                          child: Text(
                            "${_global_key.emergency_contact_list[index].name}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Text(
                    "Please add emergency contact",
                    textAlign: TextAlign.center,
                  ),
          ],
        );
      },
    );
  }

  //scream alarm functions
  void _show_scream_alarm_functions() {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return Alarm_Dialog();
      },
    );
  }

  // void _show_scream_alarm_functions() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SimpleDialog(
  //         contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 5),
  //         backgroundColor: Colors.grey[100],
  //         children: [
  //           Container(
  //             alignment: Alignment.center,
  //             child: Text(
  //               "Scream Alarm Functions",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 fontSize: 30,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           Divider(
  //             color: Colors.black,
  //           ),
  //           Container(
  //             width: 150,
  //             child: RaisedButton(
  //               elevation: 5,
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 _show_select_scream_alarm();
  //               },
  //               child: Text(
  //                 "Make Loud Alarm Sound",
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Container(
  //             width: 200,
  //             child: RaisedButton(
  //               elevation: 5,
  //               onPressed: () {
  //                 // _saveFile();
  //               },
  //               child: Text(
  //                 "Add Alarm Sound",
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Container(
  //             width: 200,
  //             child: RaisedButton(
  //               elevation: 5,
  //               onPressed: () {},
  //               child: Text(
  //                 "Delete Alarm Sound",
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _show_select_scream_alarm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 5),
          backgroundColor: Colors.grey[100],
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Select Scream Alarm",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              width: 150,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_confirmation_dialog(null);
                },
                child: Text(
                  "Sound 1",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_confirmation_dialog(null);
                },
                child: Text(
                  "Sound 2",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: RaisedButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  _show_confirmation_dialog(null);
                },
                child: Text(
                  "Sound 3",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (_global_key.user_list.isNotEmpty) {
      _db.update_useraccount(
          _global_key.user_list[0]["username"],
          _global_key.password,
          _global_key.user_list[0]["username"],
          _global_key.password,
          _global_key.user_list[0]["phone"],
          _global_key.user_list[0]["email"],
          _global_key.user_list[0]["name"],
          _global_key.user_list[0]["gender"],
          _global_key.user_list[0]["identification_type"],
          _global_key.user_list[0]["identification_number"],
          _global_key.user_list[0]["identification_photo"],
          "1");
    }

    //changed + username
    _db.retrive_message(
      _global_key.user_list.isNotEmpty
          ? _global_key.user_list[0]["username"]
          : _global_key.user_list_local[0].username,
    );
    _db.retrive_emergency_contact(
      _global_key.user_list.isNotEmpty
          ? _global_key.user_list[0]["username"]
          : _global_key.user_list_local[0].username,
    );
    _db.retrieve_alarm(
      _global_key.user_list.isNotEmpty
          ? _global_key.user_list[0]["username"]
          : _global_key.user_list_local[0].username,
    );

    print("hihihihihi ${_global_key.quick_action_index}");

    Future.delayed(Duration(seconds: 2), () {
      if (_global_key.quick_action_index == 0) {
        _show_instant_message_functions();
      } else if (_global_key.quick_action_index == 1) {
      } else if (_global_key.quick_action_index == 2) {
        _show_scream_alarm_functions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          elevation: 20,
          shadowColor: Colors.green[900],
          backgroundColor: Colors.green[400],
          leading: GestureDetector(
            onTap: _show_usermanual,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Icon(
                Icons.help_outline,
                size: 40,
                color: Colors.indigo[900],
              ),
            ),
          ),
          //title: Text('Material App Bar'),
        ),
        body: Container(
          height: _screen_height,
          color: Colors.green[50].withOpacity(0.5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  elevation: 13,
                  shape: Border.all(width: 0.2),
                  shadowColor: Colors.yellow[900],
                  color: Colors.yellow[50],
                  child: Container(
                    // /margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
                    height: 150,
                    //width: _screen_width / 3,
                    child: ListTile(
                      onTap: _show_instant_message_functions,
                      dense: true,
                      trailing: Container(
                        //margin: EdgeInsets.fromLTRB(0, 27, 0, 0),
                        child: Icon(
                          Icons.mail_outline,
                          size: 100,
                        ),
                      ),
                      title: Text(
                        "instant_message".tr().toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue[900],
                        ),
                      ),
                      subtitle: Text(
                        "instant_message_description".tr().toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  elevation: 13,
                  shape: Border.all(width: 0.3),
                  shadowColor: Colors.cyan[900],
                  color: Colors.cyan[50],
                  child: Container(
                    height: 150,
                    //width: _screen_width / 3,
                    child: ListTile(
                      onTap: _show_instant_call_receivers,
                      dense: true,
                      trailing: Container(
                        //margin: EdgeInsets.fromLTRB(0, 27, 0, 0),
                        child: Icon(
                          Icons.phone_in_talk,
                          size: 100,
                        ),
                      ),
                      title: Text(
                        "instant_call".tr().toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue[900],
                        ),
                      ),
                      subtitle: Text(
                        "instant_call_description".tr().toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
                  elevation: 10,
                  shape: Border.all(width: 0.1),
                  shadowColor: Colors.red[300],
                  color: Colors.red[50],
                  child: Container(
                    constraints: BoxConstraints(minHeight: 150),
                    child: ListTile(
                      onTap: () {
                        _show_scream_alarm_functions();
                        // showDialog(
                        //   context: context,
                        //   // barrierDismissible: false,
                        //   builder: (BuildContext context) {
                        //     return Alarm_Dialog();
                        //   },
                        // );
                      },
                      dense: true,
                      trailing: Container(
                        child: Icon(
                          Icons.warning,
                          size: 100,
                        ),
                      ),
                      title: Text(
                        "scream_alarm".tr().toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue[900],
                        ),
                      ),
                      subtitle: Text(
                        "scream_alarm_description".tr().toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(vertical: BorderSide(width: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.green[600].withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 30,
                offset: Offset(0, -5), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              _build_bottom_navigation_bar_item(
                index: 0,
                icon: Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.indigo[900],
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _build_bottom_navigation_bar_item(
                index: 1,
                icon: Icon(
                  Icons.location_on,
                  size: 30,
                  color: Colors.indigo[900],
                ),
                title: Text(
                  "Location",
                  style: TextStyle(
                      color: Colors.indigo[900], fontWeight: FontWeight.bold),
                ),
              ),
              _build_bottom_navigation_bar_item(
                index: 2,
                icon: Icon(
                  Icons.person_pin,
                  size: 30,
                  color: Colors.indigo[900],
                ),
                title: Text(
                  "Account",
                  style: TextStyle(
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // _build_bottom_navigation_bar_item(
              //   index: 3,
              //   icon: Icon(
              //     Icons.person_pin,
              //     size: 30,
              //   ),
              //   title: "Account",
              // ),
            ],
          ),
        ),
      ),
    );
  }

  //customised bottom navigation bar item
  Widget _build_bottom_navigation_bar_item({int index, Icon icon, Text title}) {
    return GestureDetector(
      onTap: () => setState(
        () {
          _global_key.navigation_bar_index = index;
          //print(index); //check index
          if (index == 1)
            Navigator.of(context).pushReplacementNamed("/LocationScreen");
          else if (index == 2)
            Navigator.of(context).pushReplacementNamed("/ProfileScreen");
        },
      ),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 3,
        padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
        decoration: BoxDecoration(
          gradient: _global_key.navigation_bar_index == index
              ? LinearGradient(
                  colors: [
                    Colors.green[400],
                    Colors.green[400],
                    // Colors.indigo[900].withOpacity(1),
                    // Colors.indigo[900].withOpacity(1),
                    //Colors.indigo[600],
                    //Colors.indigo[900].withOpacity(0.01),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )
              : LinearGradient(
                  colors: [
                    Colors.green[400],
                    Colors.green[400],
                    // Colors.indigo[900].withOpacity(1),
                    // Colors.indigo[900].withOpacity(1),
                  ],
                  // begin: Alignment.bottomCenter,
                  // end: Alignment.topCenter,
                ),
        ),
        child: Column(
          children: [
            icon,
            title,
          ],
        ),
      ),
    );
  }
}

class Alarm_Dialog extends StatefulWidget {
  @override
  _Alarm_Dialog_State createState() => _Alarm_Dialog_State();
}

class _Alarm_Dialog_State extends State<Alarm_Dialog> {
  GlobalState _global_key = GlobalState.instance;
  DB _db = DB.instance;
  int _previous_selected_alarm_index;
  List<bool> _selected_alarm = List();
  AudioPlayer _audio_player = AudioPlayer();
  Directory _directory;

  // open new file in android device and save file into it
  Future<bool> _saveFile() async {
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
        } else {
          return false;
        }
      }
      if (!await _directory.exists()) {
        await _directory.create(recursive: true);
      }
      if (await _directory.exists()) {
        //file picker function
        _open_file_explorer(_directory.path);

        // load file from assets
        ByteData data = await rootBundle.load('asset/sounds/Female Scream.mp3');
        //copy paste file to specific directory
        File file = File('${_directory.path}/Female Scream.mp3');
        ByteBuffer buffer = data.buffer;
        print(await file.writeAsBytes(
            buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)));
        print("no");

        // load file from assets
        data = await rootBundle.load('asset/sounds/Police siren.mp3');
        //copy paste file to specific directory
        file = File('${_directory.path}/Police siren.mp3');
        buffer = data.buffer;
        print(await file.writeAsBytes(
            buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)));
      }
    } catch (e) {
      print(e);
    }
  }

  void _get_storage_directory() async {
    _directory = await getExternalStorageDirectory();
    print(_directory.path);
    String newPath = "";
    List<String> folders = _directory.path.split("/");
    for (int i = 1; i < folders.length; i++) {
      String folder = folders[i];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    newPath = newPath + "/safety000";
    _directory = Directory(newPath);
    print(_directory.path);
  }

  void _open_file_explorer(String directory) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      if (!mounted) return;
      files.forEach((file) async {
        String path = "${directory}/${file.path.split('/').last}";
        //copy internal file to app storage
        File newFile = await file.copy(path);
        _db.insert_alarm(
          _global_key.user_list.isNotEmpty
              ? _global_key.user_list[0]["username"]
              : _global_key.user_list_local[0].username,
          "${file.path.split('/').last}",
        );
      });
      Navigator.of(context).pop();
    } else {
      // User canceled the picker
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  void _set_audio_player(String path_alarm) async {
    var duration =
        await _audio_player.setFilePath("${_directory.path}/${path_alarm}");
    await _audio_player.setLoopMode(LoopMode.one);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < _global_key.alarm_list.length; i++) {
      _selected_alarm.add(false);
    }
    _get_storage_directory();
  }

  @override
  void dispose() {
    super.dispose();
    _audio_player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 5),
      backgroundColor: Colors.grey[100],
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            "scream_alarm".tr().toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
          width: 200,
          child: RaisedButton(
            elevation: 5,
            onPressed: () {
              _saveFile();
            },
            child: Text(
              "add_scream_alarm_homepage".tr().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
          constraints: BoxConstraints(minWidth: 0, maxWidth: double.maxFinite),
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _global_key.alarm_list.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  index > 1
                      ? GestureDetector(
                          onTap: () {
                            _db.delete_alarm(
                              _global_key.alarm_list[index].username,
                              _global_key.alarm_list[index].alarm_name,
                            );
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                              size: 27,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.fromLTRB(27, 0, 0, 0),
                        ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_previous_selected_alarm_index != null) {
                          _selected_alarm[_previous_selected_alarm_index] =
                              false;
                          _audio_player.stop();
                        }
                        _selected_alarm[index] = !_selected_alarm[index];
                        _previous_selected_alarm_index = index;
                        if (_selected_alarm[index] == true) {
                          _set_audio_player(
                              _global_key.alarm_list[index].alarm_name);
                          _audio_player.play();
                        }
                        if (_selected_alarm[index] == false) {}
                      });
                    },
                    child: Card(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      elevation: 4,
                      color: _selected_alarm[index] == true
                          ? Colors.green
                          : Colors.grey[50],
                      child: Container(
                        height: 25,
                        child: Text(
                          _global_key.alarm_list[index].alarm_name,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
