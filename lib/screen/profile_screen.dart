import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:project1/emergency_contact.dart';
import 'package:toast/toast.dart';
import 'package:project1/global_value.dart';
import '../database.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

enum MenuOption { ChangeLanguage, LogOut }

class Profile_Screen extends StatefulWidget {
  @override
  _Profile_Screen_State createState() => _Profile_Screen_State();
}

class _Profile_Screen_State extends State<Profile_Screen> {
  //user
  String _identification_photo; //from album or take photo
  String _gender; //radio button
  String _identification_type; //radio button
  TextEditingController _name_controller = TextEditingController();
  TextEditingController _identification_number_controller =
      TextEditingController();
  TextEditingController _phone_number_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  String _phone_number; //get from database
  String _email; //get from database

  //emergency contact
  TextEditingController _contact_name_controller = TextEditingController();
  TextEditingController _contact_number_controller = TextEditingController();
  TextEditingController _contact_relationship_controller =
      TextEditingController();
  String _contact_name;
  String _contact_phone_number;
  String _relationship;

  GlobalKey<FormState> _form_key = GlobalKey<FormState>();

  GlobalState _global_key = GlobalState.instance;
  DB _db = DB.instance;
  File newFile;
  Directory _directory;

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

  void _add_new_emergency_contact_dialog() {
    // double _screen_width1 =
    //     MediaQuery.of(context).size.width; //need checking on mobile phone
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          titlePadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text(
            "new_emergency_contact".tr().toString(),
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          children: [
            Divider(
              color: Colors.black,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: TextFormField(
                controller: _contact_name_controller,
                keyboardType: TextInputType.text,
                // autovalidate: true,
                // validator: MultiValidator([
                //   RequiredValidator(
                //       errorText:
                //           'Please fill in contact name'),
                //   // EmailValidator(
                //   //     errorText: 'Invalid username format'),
                // ]),
                decoration: InputDecoration(
                  labelText: 'Contact Name',
                  labelStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.lightBlue[900],
                    fontWeight: FontWeight.bold,
                  ),
                  errorStyle: TextStyle(
                      color: Colors.blueAccent[700],
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
              child: TextFormField(
                controller: _contact_number_controller,
                keyboardType: TextInputType.phone,
                // autovalidate: true,
                // validator: MultiValidator([
                //   RequiredValidator(
                //       errorText:
                //           'Please fill in contact name'),
                //   // EmailValidator(
                //   //     errorText: 'Invalid username format'),
                // ]),
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  labelStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.lightBlue[900],
                    fontWeight: FontWeight.bold,
                  ),
                  errorStyle: TextStyle(
                      color: Colors.blueAccent[700],
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: TextFormField(
                controller: _contact_relationship_controller,
                keyboardType: TextInputType.text,
                // autovalidate: true,
                // validator: MultiValidator([
                //   RequiredValidator(
                //       errorText:
                //           'Please fill in contact name'),
                //   // EmailValidator(
                //   //     errorText: 'Invalid username format'),
                // ]),
                decoration: InputDecoration(
                  labelText: 'Relationship',
                  labelStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.lightBlue[900],
                    fontWeight: FontWeight.bold,
                  ),
                  errorStyle: TextStyle(
                      color: Colors.blueAccent[700],
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(0),
              child: Divider(
                thickness: 1,
                color: Colors.grey[700],
                indent: 0,
                endIndent: 0,
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // width: _screen_width1 / 3,
                    child: FlatButton(
                      onPressed: () {
                        _db.insert_emergency_contact(
                          _global_key.user_list.isNotEmpty
                              ? _global_key.user_list[0]["username"]
                              : _global_key.user_list_local[0].username,
                          _contact_name_controller.text,
                          _contact_number_controller.text,
                          _contact_relationship_controller.text,
                        );
                        _contact_name_controller.clear();
                        _contact_number_controller.clear();
                        _contact_relationship_controller.clear();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: Colors.grey[700],
                    indent: 0,
                    endIndent: 5,
                  ),
                  Container(
                    // width: _screen_width1 / 3,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  //nice dialog design
  void _delete_emergency_contact(
      String name, String phone, String relationship) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.fromLTRB(0, 12, 20, 16),
          title: Text(
            "Do you want to delete this emergency contact?",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: FlatButton(
                    onPressed: () {
                      _db.delete_emergency_contact(
                        _global_key.user_list.isNotEmpty
                            ? _global_key.user_list[0]["username"]
                            : _global_key.user_list_local[0].username,
                        name,
                        phone,
                        relationship,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
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

  void _edit_emergency_contact_dialog(
      int id, String name, String phone, String relationship) {
    //set value to text field text
    String old_name = name;
    String old_phone = phone;
    String old_relationship = relationship;
    _contact_name_controller.text = name;
    _contact_number_controller.text = phone;
    _contact_relationship_controller.text = relationship;
    // double _screen_width1 =
    //     MediaQuery.of(context).size.width; //need checking on mobile phone
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          titlePadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          title: Text(
            "edit_emergency_contact".tr().toString(),
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          children: [
            Divider(
              color: Colors.black,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: TextFormField(
                controller: _contact_name_controller,
                keyboardType: TextInputType.text,
                // autovalidate: true,
                // validator: MultiValidator([
                //   RequiredValidator(
                //       errorText:
                //           'Please fill in contact name'),
                //   // EmailValidator(
                //   //     errorText: 'Invalid username format'),
                // ]),
                decoration: InputDecoration(
                  labelText: 'contact_name'.tr().toString(),
                  labelStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.lightBlue[900],
                    fontWeight: FontWeight.bold,
                  ),
                  errorStyle: TextStyle(
                      color: Colors.blueAccent[700],
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
              child: TextFormField(
                controller: _contact_number_controller,
                keyboardType: TextInputType.phone,
                // autovalidate: true,
                // validator: MultiValidator([
                //   RequiredValidator(
                //       errorText:
                //           'Please fill in contact name'),
                //   // EmailValidator(
                //   //     errorText: 'Invalid username format'),
                // ]),
                decoration: InputDecoration(
                  labelText: 'contact_number'.tr().toString(),
                  labelStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.lightBlue[900],
                    fontWeight: FontWeight.bold,
                  ),
                  errorStyle: TextStyle(
                      color: Colors.blueAccent[700],
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: TextFormField(
                controller: _contact_relationship_controller,
                keyboardType: TextInputType.text,
                // autovalidate: true,
                // validator: MultiValidator([
                //   RequiredValidator(
                //       errorText:
                //           'Please fill in contact name'),
                //   // EmailValidator(
                //   //     errorText: 'Invalid username format'),
                // ]),
                decoration: InputDecoration(
                  labelText: 'relationship'.tr().toString(),
                  labelStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.lightBlue[900],
                    fontWeight: FontWeight.bold,
                  ),
                  errorStyle: TextStyle(
                      color: Colors.blueAccent[700],
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(0),
              child: Divider(
                thickness: 1,
                color: Colors.grey[700],
                indent: 0,
                endIndent: 0,
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // width: _screen_width1 / 3,
                    child: FlatButton(
                      onPressed: () {
                        _db.update_emergency_contact(
                          id,
                          _global_key.user_list.isNotEmpty
                              ? _global_key.user_list[0]["username"]
                              : _global_key.user_list_local[0].username,
                          old_name,
                          old_phone,
                          old_relationship,
                          _contact_name_controller.text,
                          _contact_number_controller.text,
                          _contact_relationship_controller.text,
                        );
                        _contact_name_controller.clear();
                        _contact_number_controller.clear();
                        _contact_relationship_controller.clear();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: Colors.grey[700],
                    indent: 0,
                    endIndent: 5,
                  ),
                  Container(
                    // width: _screen_width1 / 3,
                    child: FlatButton(
                      onPressed: () {
                        _contact_name_controller.clear();
                        _contact_number_controller.clear();
                        _contact_relationship_controller.clear();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _backup_message() async {
    String clear_messages = "true";
    String response;
    // ProgressDialog pr = ProgressDialog(context,
    //     type: ProgressDialogType.Normal, isDismissible: false);
    // pr.style(message: "Back Up Messages...");
    // await pr.show();

    for (int i = 0; i < _global_key.message_list.length; i++) {
      final res = await http.post(
        "http://icebeary.com/safety/php/backup_message.php",
        body: {
          "username": _global_key.user_list.isNotEmpty
              ? _global_key.user_list[0]["username"]
              : _global_key.user_list_local[0].username,
          "password": _global_key.user_list.isNotEmpty
              ? _global_key.password
              : _global_key.user_list_local[0].password,
          "title": _global_key.message_list[i].title,
          "content": _global_key.message_list[i].content,
          "clear_messages": clear_messages,
        },
      ).catchError((err) {
        print(err);
      });

      print(res.body);
      if (res.body == "failed") {
        Toast.show(
          "Please connect to internet",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
        response = res.body;
        break;
      } else if (res.body == "success") {
        clear_messages = "false";
        response = res.body;
      }

      // .then(
      //   (res) {
      //     print(res.body);
      //     if (res.body == "failed") {
      //       Toast.show(
      //         "Please connect to internet",
      //         context,
      //         duration: 4,
      //         gravity: Toast.BOTTOM,
      //       );
      //     } else if (res.body == "success") {
      //       bool clear_messages = false;
      //     }
      //   },
      // ).catchError((err) {
      //   print(err);
      // });
    }
    // await pr.hide();
    if (response == "success") {
      Toast.show(
        "Emergency messages and contacts are backed up",
        context,
        duration: 4,
        gravity: Toast.BOTTOM,
      );
    }
  }

  void _backup_emergency_contact() async {
    print(
      _global_key.user_list.isNotEmpty
          ? _global_key.user_list[0]["username"]
          : _global_key.user_list_local[0].username,
    );
    print(_global_key.user_list.isNotEmpty
        ? _global_key.password
        : _global_key.user_list_local[0].password);
    String clear_emergency_contacts = "true";
    String response;
    // ProgressDialog pr = ProgressDialog(context,
    //     type: ProgressDialogType.Normal, isDismissible: false);
    // pr.style(message: "Back Up Emergenct Contacts...");
    // await pr.show();

    for (int i = 0; i < _global_key.emergency_contact_list.length; i++) {
      final res = await http.post(
        "http://icebeary.com/safety/php/backup_emergency_contact.php",
        body: {
          "username": _global_key.user_list.isNotEmpty
              ? _global_key.user_list[0]["username"]
              : _global_key.user_list_local[0].username,
          "password": _global_key.user_list.isNotEmpty
              ? _global_key.password
              : _global_key.user_list_local[0].password,
          "name": _global_key.emergency_contact_list[i].name,
          "phone": _global_key.emergency_contact_list[i].phone_number,
          "relationship": _global_key.emergency_contact_list[i].relationship,
          "clear_emergency_contacts": clear_emergency_contacts,
        },
      ).catchError((err) {
        print(err);
      });

      print(res.body);
      if (res.body == "failed") {
        Toast.show(
          "Please connect to internet",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
        response = res.body;
        break;
      } else if (res.body == "success") {
        clear_emergency_contacts = "false";
        response = res.body;
      }
    }

    if (response == "success") {
      Toast.show(
        "Emergency messages and contacts are backed up",
        context,
        duration: 4,
        gravity: Toast.BOTTOM,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //this is important
    setState(
      () {
        _directory = _global_key.directory;
        if (_global_key.user_list.isNotEmpty) {
          if (_global_key.user_list[0]["identification_photo"] == "NULL") {
            newFile = null;
            print("hi1");
          } else {
            print("hi2");
            print(_global_key.user_list[0]["identification_photo"]);
            newFile = File(
                "${_global_key.directory.path}/${_global_key.user_list[0]["identification_photo"]}");
          }
        } else {
          if (_global_key.user_list_local[0].identification_photo == "NULL") {
            newFile = null;
            print("hi3");
          } else {
            print("hi4");
            newFile = File(
                "${_global_key.directory.path}/${_global_key.user_list_local[0].identification_photo}");
          }
        }
        _gender = _global_key.user_list.isNotEmpty
            ? _global_key.user_list[0]["gender"]
            : _global_key.user_list_local[0].gender;
        _identification_type = _global_key.user_list.isNotEmpty
            ? _global_key.user_list[0]["identification_type"]
            : _global_key.user_list_local[0].identification_type;
      },
    );
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
          shadowColor: Colors.black,
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
          actions: [
            Theme(
              data: Theme.of(context).copyWith(),
              child: PopupMenuButton<int>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Text("Setting Language"),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Text("Back Up Profile"),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text("Logout"),
                  ),
                ],
                initialValue: 3,
                onSelected: (value) async {
                  if (value == 0) {
                    setState(() {
                      if (_global_key.language_index == 0) {
                        _global_key.language_index = 1;
                        EasyLocalization.of(context).locale =
                            Locale('ms', 'MY');
                      } else if (_global_key.language_index == 1) {
                        _global_key.language_index = 0;
                        EasyLocalization.of(context).locale =
                            Locale('en', 'US');
                      }
                    });
                  } else if (value == 1) {
                    ProgressDialog pr = ProgressDialog(context,
                        type: ProgressDialogType.Normal, isDismissible: false);
                    pr.style(message: "Back Up Profile...");
                    await pr.show();
                    _backup_message();
                    _backup_emergency_contact();
                    await pr.hide();
                    // Navigator.of(context)
                    //     .pushReplacementNamed("/LoginAccountScreen");
                  } else if (value == 2) {
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
                        "0",
                      );
                    } else {
                      _db.update_useraccount(
                          _global_key.user_list_local[0].username,
                          _global_key.user_list_local[0].password,
                          _global_key.user_list_local[0].username,
                          _global_key.user_list_local[0].password,
                          _global_key.user_list_local[0].phone_number,
                          _global_key.user_list_local[0].email,
                          _global_key.user_list_local[0].name,
                          _global_key.user_list_local[0].gender,
                          _global_key.user_list_local[0].identification_type,
                          _global_key.user_list_local[0].identification_number,
                          _global_key.user_list_local[0].identification_photo,
                          "0");
                    }
                    Future.delayed(
                      Duration(seconds: 3),
                      () {
                        _global_key.user_list_local.clear();
                        _global_key.user_list.clear();
                        Navigator.of(context)
                            .pushReplacementNamed("/LoginAccountScreen");
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.green[50].withOpacity(0.5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //profile account part
                Card(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  shape: Border.all(width: 0.2),
                  elevation: 10,
                  shadowColor: Colors.yellow[900],
                  color: Colors.yellow[50],
                  child: Container(
                    height: _screen_height / 4,
                    child: Row(
                      children: [
                        Container(
                          width: _screen_width / 2,
                          child: Center(
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: 210,
                              ),
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              child: Container(
                                child: newFile == null
                                    ? Icon(
                                        Icons.image,
                                        size: 130,
                                        color: Colors.red[200],
                                      )
                                    : Image.file(newFile, fit: BoxFit.fill),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  _global_key.user_list.isNotEmpty
                                      ? "${_global_key.user_list[0]["name"]}"
                                      : "${_global_key.user_list_local[0].name}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  _global_key.user_list.isNotEmpty
                                      ? "${_global_key.user_list[0]["phone"]}"
                                      : "${_global_key.user_list_local[0].phone_number}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  _global_key.user_list.isNotEmpty
                                      ? "${_global_key.user_list[0]["email"]}"
                                      : "${_global_key.user_list_local[0].email}",
                                  maxLines: 5,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Personal Information Part
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Card(
                    shape: Border.all(width: 0.2),
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                              child: Text(
                                "personal_information".tr().toString(),
                                style: TextStyle(
                                    color: Colors.green[800],
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushReplacementNamed(
                                      "/ProfileInputPersonalInformationScreen"),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.deepOrange,
                                ),
                                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                padding: EdgeInsets.all(3),
                                child: Icon(
                                  Icons.edit,
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),

                        //gender
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(40, 20, 0, 0),
                          child: Text(
                            "gender".tr().toString(),
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.lightBlue[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                child: Radio(
                                  value: "Male",
                                  groupValue: _gender,
                                  // activeColor: Colors.black,
                                  // onChanged: (value) {
                                  //   setState(() {
                                  //     _gender = value;
                                  //     print(_gender);
                                  //   });
                                  // },
                                ),
                              ),
                              Text(
                                "male".tr().toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                                child: Radio(
                                  value: "Female",
                                  groupValue: _gender,
                                  // onChanged: (value) {
                                  //   setState(() {
                                  //     _gender = value;
                                  //     print(_gender);
                                  //   });
                                  // },
                                ),
                              ),
                              Text(
                                "female".tr().toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //identification type
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(40, 15, 0, 0),
                          child: Text(
                            "identification_type".tr().toString(),
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.lightBlue[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                child: Radio(
                                  value: "IC Number",
                                  groupValue: _identification_type,
                                  //activeColor: Colors.black,
                                  // onChanged: (value) {
                                  //   setState(() {
                                  //     _identification_type = value;
                                  //     print(_identification_type);
                                  //   });
                                  // },
                                ),
                              ),
                              Text(
                                "identification_card_number".tr().toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                child: Radio(
                                  value: "Passport Number",
                                  groupValue: _identification_type,
                                  //activeColor: Colors.black,
                                  // onChanged: (value) {
                                  //   setState(() {
                                  //     _identification_type = value;
                                  //     print(_identification_type);
                                  //   });
                                  // },
                                ),
                              ),
                              Text(
                                "passport_number".tr().toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                child: Radio(
                                  value: "Police Number",
                                  groupValue: _identification_type,
                                  //activeColor: Colors.black,
                                  // onChanged: (value) {
                                  //   setState(() {
                                  //     _identification_type = value;
                                  //     print(_identification_type);
                                  //   });
                                  // },
                                ),
                              ),
                              Text(
                                "police_number".tr().toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                child: Radio(
                                  value: "Military Number",
                                  groupValue: _identification_type,
                                  //activeColor: Colors.black,
                                  // onChanged: (value) {
                                  //   setState(() {
                                  //     _identification_type = value;
                                  //     print(_identification_type);
                                  //   });
                                  // },
                                ),
                              ),
                              Text(
                                "military_number".tr().toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Text Fields
                        Container(
                          //height: 75,
                          // color: Colors.green,
                          margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: TextFormField(
                            //controller: _name_controller,
                            enabled: false,
                            keyboardType: TextInputType.text,
                            // autovalidate: true,
                            // validator: MultiValidator([
                            //   RequiredValidator(
                            //       errorText: 'Please fill in name'),
                            //   // EmailValidator(
                            //   //     errorText: 'Invalid username format'),
                            // ]),
                            decoration: InputDecoration(
                              // filled: true,
                              // fillColor: Colors.white70,
                              labelText: _global_key.user_list.isNotEmpty
                                  ? "${_global_key.user_list[0]["name"]}"
                                  : "${_global_key.user_list_local[0].name}",
                              icon: Icon(
                                Icons.person,
                                color: Colors.indigo[900],
                              ),
                              labelStyle: TextStyle(
                                fontSize: 22,
                                color: Colors.lightBlue[900],
                                fontWeight: FontWeight.bold,
                              ),
                              errorStyle: TextStyle(
                                  color: Colors.blueAccent[700],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //height: 75,
                          // color: Colors.green,
                          margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: TextFormField(
                            //controller: _identification_number_controller,
                            enabled: false,
                            keyboardType: TextInputType.text,
                            // autovalidate: true,
                            // validator: MultiValidator([
                            //   RequiredValidator(
                            //       errorText:
                            //           'Please fill in identification number'),
                            //   // EmailValidator(
                            //   //     errorText: 'Invalid username format'),
                            // ]),
                            decoration: InputDecoration(
                              // filled: true,
                              // fillColor: Colors.white70,
                              labelText: _global_key.user_list.isNotEmpty
                                  ? "${_global_key.user_list[0]["identification_number"]}"
                                  : "${_global_key.user_list_local[0].identification_number}",
                              icon: Icon(
                                Icons.confirmation_number,
                                color: Colors.indigo[900],
                              ),
                              labelStyle: TextStyle(
                                fontSize: 22,
                                color: Colors.lightBlue[900],
                                fontWeight: FontWeight.bold,
                              ),
                              errorStyle: TextStyle(
                                  color: Colors.blueAccent[700],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //height: 75,
                          // color: Colors.green,
                          margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: TextFormField(
                            //controller: _phone_number_controller,
                            enabled: false,
                            //keyboardType: TextInputType.text,
                            //autovalidate: true,
                            // validator: MultiValidator([
                            //   RequiredValidator(errorText: 'Please fill in name'),
                            //   // EmailValidator(
                            //   //     errorText: 'Invalid username format'),
                            // ]),
                            decoration: InputDecoration(
                              labelText: _global_key.user_list.isNotEmpty
                                  ? "${_global_key.user_list[0]["phone"]}"
                                  : "${_global_key.user_list_local[0].phone_number}",
                              icon: Icon(
                                Icons.phone,
                                color: Colors.indigo[900],
                              ),
                              labelStyle: TextStyle(
                                fontSize: 22,
                                color: Colors.lightBlue[900],
                                fontWeight: FontWeight.bold,
                              ),
                              errorStyle: TextStyle(
                                  color: Colors.blueAccent[700],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              // errorBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(5),
                              //   borderSide: BorderSide(
                              //     width: 2,
                              //     color: Colors.green,
                              //   ),
                              // ),
                              // focusedErrorBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(5),
                              //   borderSide: BorderSide(
                              //     width: 2,
                              //     color: Colors.green,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 15, 20, 20),
                          child: TextFormField(
                            //controller: _email_controller,
                            enabled: false,

                            //keyboardType: TextInputType.text,
                            //autovalidate: true,
                            // validator: MultiValidator([
                            //   RequiredValidator(errorText: 'Please fill in name'),
                            //   // EmailValidator(
                            //   //     errorText: 'Invalid username format'),
                            // ]),
                            decoration: InputDecoration(
                              labelText: _global_key.user_list.isNotEmpty
                                  ? "${_global_key.user_list[0]["email"]}"
                                  : "${_global_key.user_list_local[0].email}",
                              icon: Icon(
                                Icons.mail,
                                color: Colors.indigo[900],
                              ),
                              labelStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.lightBlue[900],
                                fontWeight: FontWeight.bold,
                              ),
                              errorStyle: TextStyle(
                                  color: Colors.blueAccent[700],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Emergency Contact Part
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child: Card(
                    shape: Border.all(width: 0.2),
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "emergency_contact_information".tr().toString(),
                            style: TextStyle(
                                color: Colors.green[800],
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            _add_new_emergency_contact_dialog();
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.greenAccent[700],
                              size: 30,
                            ),
                          ),
                        ),

                        //Emergency contacts show here
                        Container(
                          constraints: BoxConstraints(
                              minWidth: 0, maxWidth: double.maxFinite),
                          width: double.maxFinite,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                _global_key.emergency_contact_list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Column(
                                  children: [
                                    Divider(
                                      thickness: 1,
                                      color: Colors.grey[700],
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Text(
                                            "emergency_contact"
                                                    .tr()
                                                    .toString() +
                                                " ${index + 1}",
                                            style: TextStyle(
                                              color: Colors.blue[600],
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              _delete_emergency_contact(
                                                _global_key
                                                    .emergency_contact_list[
                                                        index]
                                                    .name,
                                                _global_key
                                                    .emergency_contact_list[
                                                        index]
                                                    .phone_number,
                                                _global_key
                                                    .emergency_contact_list[
                                                        index]
                                                    .relationship,
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                                size: 27,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                _edit_emergency_contact_dialog(
                                              _global_key
                                                  .emergency_contact_list[index]
                                                  .id,
                                              _global_key
                                                  .emergency_contact_list[index]
                                                  .name,
                                              _global_key
                                                  .emergency_contact_list[index]
                                                  .phone_number,
                                              _global_key
                                                  .emergency_contact_list[index]
                                                  .relationship,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.deepOrange,
                                              ),
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              padding: EdgeInsets.all(3),
                                              child: Icon(
                                                Icons.edit,
                                                size: 17,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(18, 10, 18, 0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          labelText:
                                              '${_global_key.emergency_contact_list[index].name}',
                                          icon: Icon(
                                            Icons.person,
                                            color: Colors.indigo[900],
                                          ),
                                          labelStyle: TextStyle(
                                            fontSize: 22,
                                            color: Colors.lightBlue[900],
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorStyle: TextStyle(
                                              color: Colors.blueAccent[700],
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      //height: 75,
                                      // color: Colors.green,
                                      margin:
                                          EdgeInsets.fromLTRB(18, 15, 18, 0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          // filled: true,
                                          // fillColor: Colors.white70,
                                          labelText:
                                              '${_global_key.emergency_contact_list[index].phone_number}',
                                          icon: Icon(
                                            Icons.phone,
                                            color: Colors.indigo[900],
                                          ),
                                          labelStyle: TextStyle(
                                            fontSize: 22,
                                            color: Colors.lightBlue[900],
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorStyle: TextStyle(
                                              color: Colors.blueAccent[700],
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      //height: 75,
                                      // color: Colors.green,
                                      margin:
                                          EdgeInsets.fromLTRB(18, 15, 18, 10),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          labelText:
                                              '${_global_key.emergency_contact_list[index].relationship}',
                                          icon: Icon(
                                            Icons.linear_scale,
                                            color: Colors.indigo[900],
                                          ),
                                          labelStyle: TextStyle(
                                            fontSize: 22,
                                            color: Colors.lightBlue[900],
                                            fontWeight: FontWeight.bold,
                                          ),
                                          errorStyle: TextStyle(
                                              color: Colors.blueAccent[700],
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
          if (index == 0) {
            Navigator.of(context).pushReplacementNamed("/HomeScreen");
          } else if (index == 1)
            Navigator.of(context).pushReplacementNamed("/LocationScreen");
          else if (index == 2)
            Navigator.of(context).pushReplacementNamed("/ProfileScreen");
          // else if (index == 3)
          //   Navigator.of(context).pushReplacementNamed("/ProfileScreen");
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
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )
              : LinearGradient(
                  colors: [
                    Colors.green[400],
                    Colors.green[400],
                  ],
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

  //customised menu drop down list
}
