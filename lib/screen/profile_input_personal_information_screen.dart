import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:toast/toast.dart';
import '../global_value.dart';
import '../database.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class Profile_Input_Personal_Information_Screen extends StatefulWidget {
  @override
  _Profile_Input_Personal_Information_Screen_State createState() =>
      _Profile_Input_Personal_Information_Screen_State();
}

class _Profile_Input_Personal_Information_Screen_State
    extends State<Profile_Input_Personal_Information_Screen> {
  //user
  String _identification_photo; //from album or take photo
  String _gender; //radio button
  String _identification_type; //radio button
  TextEditingController _name_controller = TextEditingController();
  TextEditingController _identification_number_controller =
      TextEditingController();
  TextEditingController _phone_number_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();

  DB _db = DB.instance;
  GlobalKey<FormState> _form_key = GlobalKey<FormState>();
  GlobalState _global_key = GlobalState.instance;
  // File _image;
  // String _base64Image;
  // String _filename;
  File newFile;
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
      }
    } catch (e) {
      print(e);
    }
  }

  void _open_file_explorer(String directory) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        List<File> files = result.paths.map((path) => File(path)).toList();
        if (!mounted) return;
        files.forEach((file) async {
          String path = "${_directory.path}/${file.path.split('/').last}";
          //copy internal file to app storage
          newFile = await file.copy(path);
          print(newFile);
          _global_key.user_list.isNotEmpty
              ? _global_key.user_list[0]["identification_photo"] =
                  file.path.split('/').last
              : _global_key.user_list_local[0].identification_photo =
                  file.path.split('/').last;
          print(_global_key.user_list[0]["identification_photo"]);
          // print(_global_key.photo);
        });
      }); //setstate

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

  void _update_user_profile() async {
    // print(_global_key.user_list[0]["username"]);
    // print(_global_key.password);
    // print(_global_key.user_list[0]["phone"]);
    // print(_global_key.user_list[0]["email"]);
    // print(_name_controller.text);
    // print(_gender);
    // print(_identification_type);
    // print(_identification_number_controller.text);
    // print(_global_key.user_list[0]["identification_photo"]);
    String base64Image;
    if (newFile != null) {
      base64Image = base64Encode(newFile.readAsBytesSync());
    } else {
      base64Image = "NULL";
    }
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Updating...");
    await pr.show();
    if (_global_key.user_list.isNotEmpty) {
      print("hello");
      http.post("http://icebeary.com/safety/php/update_user_profile.php",
          body: {
            "base64_image": base64Image,
            "old_username": _global_key.user_list[0]["username"],
            "old_password": _global_key.password,
            "new_username": _global_key.user_list[0]["username"],
            "new_password": _global_key.password,
            "phone": _phone_number_controller.text,
            "email": _email_controller.text,
            "name": _name_controller.text,
            "gender": _gender,
            "identification_type": _identification_type,
            "identification_number": _identification_number_controller.text,
            "identification_photo":
                _global_key.user_list[0]["identification_photo"] != "NULL"
                    ? _global_key.user_list[0]["identification_photo"]
                    : "NULL",
          }).then((res) {
        print(res.body);
        if (res.body == "failed") {
          Toast.show(
            "Please connect to internet",
            context,
            duration: 4,
            gravity: Toast.BOTTOM,
          );
        } else {
          var user_jscode = json.decode(res.body);
          _global_key.user_list = user_jscode['user'];
          _db.update_useraccount(
            _global_key.user_list[0]["username"],
            _global_key.password,
            _global_key.user_list[0]["username"],
            _global_key.password,
            _phone_number_controller.text,
            _email_controller.text,
            _name_controller.text,
            _gender,
            _identification_type,
            _identification_number_controller.text,
            _global_key.user_list[0]["identification_photo"] != "NULL"
                ? _global_key.user_list[0]["identification_photo"]
                : "NULL",
            "1",
          );

          Future.delayed(
            Duration(seconds: 2),
            () {
              Navigator.of(context).pushReplacementNamed("/ProfileScreen");
            },
          );
        }
      }).catchError((err) {
        print(err);
      });
    } else {
      print("hellohello");
      http.post("http://icebeary.com/safety/php/update_user_profile.php",
          body: {
            "base64_image": base64Image,
            "old_username": _global_key.user_list_local[0].username,
            "old_password": _global_key.user_list_local[0].password,
            "new_username": _global_key.user_list_local[0].username,
            "new_password": _global_key.user_list_local[0].password,
            "phone": _phone_number_controller.text,
            "email": _email_controller.text,
            "name": _name_controller.text,
            "gender": _gender,
            "identification_type": _identification_type,
            "identification_number": _identification_number_controller.text,
            "identification_photo":
                _global_key.user_list_local[0].identification_photo != "NULL"
                    ? _global_key.user_list_local[0].identification_photo
                    : "NULL",
          }).then((res) {
        print(res.body);
        if (res.body == "failed") {
          Toast.show(
            "Please connect to internet",
            context,
            duration: 4,
            gravity: Toast.BOTTOM,
          );
        } else {
          var user_jscode = json.decode(res.body);
          _global_key.user_list = user_jscode['user'];
          _db.update_useraccount(
            _global_key.user_list_local[0].username,
            _global_key.user_list_local[0].password,
            _global_key.user_list_local[0].username,
            _global_key.user_list_local[0].password,
            _phone_number_controller.text,
            _email_controller.text,
            _name_controller.text,
            _gender,
            _identification_type,
            _identification_number_controller.text,
            _global_key.user_list_local[0].identification_photo != "NULL"
                ? _global_key.user_list_local[0].identification_photo
                : "NULL",
            "1",
          );

          Future.delayed(
            Duration(seconds: 2),
            () {
              Navigator.of(context).pushReplacementNamed("/ProfileScreen");
            },
          );
        }
      }).catchError((err) {
        print(err);
      });
    }
    await pr.hide();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _directory = _global_key.directory;
    // _global_key.user_list_local[0].identification_photo != null
    //     ? print("yes")
    //     : print("no");
    print(_directory);
    print(_global_key.user_list.length);
    // print(_global_key.user_list[0]["identification_photo"]);
    // print(_global_key.user_list_local[0].identification_photo);
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
    // newFile = _global_key.user_list.isNotEmpty
    //     ? File(
    //         "${_global_key.directory.path}/${_global_key.user_list[0]["identification_photo"]}")
    //     : File(
    //         "${_global_key.directory.path}/${_global_key.user_list_local[0].identification_photo}");
    _gender = _global_key.user_list.isNotEmpty
        ? _global_key.user_list[0]["gender"]
        : _global_key.user_list_local[0].gender;
    _identification_type = _global_key.user_list.isNotEmpty
        ? _global_key.user_list[0]["identification_type"]
        : _global_key.user_list_local[0].identification_type;
    _name_controller.text = _global_key.user_list.isNotEmpty
        ? _global_key.user_list[0]["name"]
        : _global_key.user_list_local[0].name;
    _identification_number_controller.text = _global_key.user_list.isNotEmpty
        ? _global_key.user_list[0]["identification_number"]
        : _global_key.user_list_local[0].identification_number;
    _phone_number_controller.text = _global_key.user_list.isNotEmpty
        ? _global_key.user_list[0]["phone"]
        : _global_key.user_list_local[0].phone_number;
    _email_controller.text = _global_key.user_list.isNotEmpty
        ? _global_key.user_list[0]["email"]
        : _global_key.user_list_local[0].email;
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () {
          Future.value(false);
          Navigator.of(context).pushReplacementNamed("/ProfileScreen");
        },
        child: Scaffold(
          resizeToAvoidBottomPadding: true,
          body: Container(
            color: Colors.purple[50],
            child: Form(
              key: _form_key,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
                  child: Card(
                    shape: Border.all(width: 0.2),
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "personal_information".tr().toString(),
                                style: TextStyle(
                                    color: Colors.green[800],
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),

                        //photo
                        // Center(
                        //   child: Container(
                        //     height: 150,
                        //     width: 210,
                        //     decoration: BoxDecoration(
                        //       border: Border.all(width: 2),
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     child: GestureDetector(
                        //       child: _image == null
                        //           ? Icon(
                        //               Icons.image,
                        //               size: 130,
                        //               color: Colors.red[200],
                        //             )
                        //           : Image.file(_image),
                        //       onTap: null,
                        //     ),
                        //   ),
                        // ),

                        Center(
                          child: Container(
                            height: 150,
                            width: 210,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: GestureDetector(
                              //Image gesture
                              child: newFile == null
                                  ? Icon(
                                      Icons.image,
                                      size: 130,
                                      color: Colors.red[200],
                                    )
                                  : Image.file(newFile),
                              onTap: () {
                                _saveFile();
                              },
                            ),
                            // Photo_State(),
                            // GestureDetector(
                            //   //Image gesture
                            //   child: _image == null
                            //       ? Icon(
                            //           Icons.image,
                            //           size: 130,
                            //           color: Colors.red[200],
                            //         )
                            //       : Image.file(newFile),
                            //   onTap: () {
                            //     setState(() {
                            //       _saveFile();
                            //     });
                            //   },
                            // ),
                          ),
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
                                  //activeColor: Colors.black,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                      print(_gender);
                                    });
                                  },
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
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                      print(_gender);
                                    });
                                  },
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
                                  onChanged: (value) {
                                    setState(() {
                                      _identification_type = value;
                                      print(_identification_type);
                                    });
                                  },
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
                                  onChanged: (value) {
                                    setState(() {
                                      _identification_type = value;
                                      print(_identification_type);
                                    });
                                  },
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
                                  onChanged: (value) {
                                    setState(() {
                                      _identification_type = value;
                                      print(_identification_type);
                                    });
                                  },
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
                                  onChanged: (value) {
                                    setState(() {
                                      _identification_type = value;
                                      print(_identification_type);
                                    });
                                  },
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
                            controller: _name_controller,
                            keyboardType: TextInputType.text,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText: 'name_error_text1'.tr().toString(),
                              ),
                            ]),
                            decoration: InputDecoration(
                              labelText: 'name'.tr().toString(),
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
                            controller: _identification_number_controller,
                            keyboardType: TextInputType.text,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText: 'identification_number_error_text1'
                                    .tr()
                                    .toString(),
                              ),
                            ]),
                            decoration: InputDecoration(
                              // filled: true,
                              // fillColor: Colors.white70,
                              labelText:
                                  'identification_number'.tr().toString(),
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
                            controller: _phone_number_controller,
                            keyboardType: TextInputType.phone,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText: 'contact_number_error_text1'
                                    .tr()
                                    .toString(),
                              ),
                            ]),
                            decoration: InputDecoration(
                              labelText: 'phone_number'.tr().toString(),
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
                          margin: EdgeInsets.fromLTRB(20, 15, 20, 20),
                          child: TextFormField(
                            controller: _email_controller,
                            keyboardType: TextInputType.text,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText: 'email_error_text1'.tr().toString(),
                              ),
                              EmailValidator(
                                errorText: 'email_error_text2'.tr().toString(),
                              ),
                            ]),
                            decoration: InputDecoration(
                              labelText: 'email'.tr().toString(),
                              icon: Icon(
                                Icons.mail,
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
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.fromLTRB(0, 20, 30, 25),
                          child: Container(
                            width: 150,
                            child: RaisedButton(
                              color: Colors.green[800],
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {
                                //if the 2 input are corect, process this
                                //need internet connection
                                if (_form_key.currentState.validate()) {
                                  // _db.update_useraccount(
                                  //   _global_key.user_list[0]["username"],
                                  //   _global_key.password,
                                  //   _global_key.user_list[0]["username"],
                                  //   _global_key.password,
                                  //   _global_key.user_list[0]["phone"],
                                  //   _global_key.user_list[0]["email"],
                                  //   _name_controller.text,
                                  //   _gender,
                                  //   _identification_type,
                                  //   _identification_number_controller.text,
                                  //   null,
                                  // );
                                  _update_user_profile();
                                }
                                // if the any input is failed, process this
                                else {
                                  // Navigator.of(context).pushReplacementNamed(
                                  //     "/ProfileInputPersonalInformationScreen");

                                  // Navigator.of(context)
                                  //     .pushReplacementNamed("/HomeScreen");

                                  Toast.show(
                                    "Please fill in all information",
                                    context,
                                    duration: 4,
                                    gravity: Toast.BOTTOM,
                                  );
                                }
                              },
                              child: Text(
                                "done".tr().toString(),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
