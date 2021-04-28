import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import '../global_value.dart';
import '../database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

class Input_Information_Screen extends StatefulWidget {
  @override
  _Input_Information_Screen_State createState() =>
      _Input_Information_Screen_State();
}

class _Input_Information_Screen_State extends State<Input_Information_Screen> {
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

  //user
  String name;
  String gender;
  String identification_photo;
  String identification_type;
  String identification_number;
  String phone_number;
  String email;
  String _image;

  //emergency contact
  String contact_name;
  String contact_phone_number;
  String relationship;

  DB _db = DB.instance;
  GlobalKey<FormState> _form_key = GlobalKey<FormState>();
  GlobalState _global_key = GlobalState.instance;
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

  // void _get_storage_directory() async {
  //   _directory = await getExternalStorageDirectory();
  //   print(_directory.path);
  //   String newPath = "";
  //   List<String> folders = _directory.path.split("/");
  //   for (int i = 1; i < folders.length; i++) {
  //     String folder = folders[i];
  //     if (folder != "Android") {
  //       newPath += "/" + folder;
  //     } else {
  //       break;
  //     }
  //   }
  //   //safety001 for image
  //   newPath = newPath + "/safety001";
  //   _directory = Directory(newPath);
  //   print(_directory.path);
  // }

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
          // _global_key.photo = newFile;
          _global_key.user_list.isNotEmpty
              ? _global_key.user_list[0]["identification_photo"] =
                  file.path.split('/').last
              : _global_key.user_list_local[0].identification_photo =
                  file.path.split('/').last;
          // print(_global_key.user_list[0]["identification_photo"]);
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

  // File _image;
  // String _base64Image;
  // String _filename;

  // Future _get_image() async {
  //   // final image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   final image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = image;
  //     _base64Image = base64Encode(_image.readAsBytesSync());
  //     _filename = _image.path.split("/").last;
  //     print(_image);
  //     print(_base64Image);
  //     print(_filename);
  //   });
  // }

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
    }
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Processing...");
    await pr.show();
    http.post("http://icebeary.com/safety/php/update_user_profile.php", body: {
      // "base64_image": base64Image,
      "old_username": _global_key.user_list[0]["username"],
      "old_password": _global_key.password,
      "new_username": _global_key.user_list[0]["username"],
      "new_password": _global_key.password,
      "phone": _global_key.user_list[0]["phone"],
      "email": _global_key.user_list[0]["email"],
      "name": _name_controller.text,
      "gender": _gender,
      "identification_type": _identification_type,
      "identification_number": _identification_number_controller.text,
      "identification_photo":
          _global_key.user_list[0]["identification_photo"] != null
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

        // _db.update_useraccount(
        //     _global_key.user_list[0]["username"],
        //     _global_key.password,
        //     _global_key.user_list[0]["username"],
        //     _global_key.password,
        //     _global_key.user_list[0]["phone"],
        //     _global_key.user_list[0]["email"],
        //     _name_controller.text,
        //     _gender,
        //     _identification_type,
        //     _identification_number_controller.text,
        //     _global_key.user_list[0]["identification_photo"],
        //     "0");

        if (_contact_name_controller.text.isNotEmpty &&
            _contact_number_controller.text.isNotEmpty &&
            _contact_relationship_controller.text.isNotEmpty) {
          _db.insert_emergency_contact(
            _global_key.user_list[0]["username"],
            _contact_name_controller.text,
            _contact_number_controller.text,
            _contact_relationship_controller.text,
          );
        }

        Navigator.of(context).pushReplacementNamed("/HomeScreen");
        // else {
        //   _db.update_useraccount(
        //       _global_key.user_list_local[0].username,
        //       _global_key.user_list_local[0].password,
        //       _global_key.user_list_local[0].username,
        //       _global_key.user_list_local[0].password,
        //       _global_key.user_list_local[0].phone_number,
        //       _global_key.user_list_local[0].email,
        //       _name_controller.text,
        //       _gender,
        //       _identification_type,
        //       _identification_number_controller.text,
        //       _global_key.user_list_local[0].identification_photo,
        //       "1");
        //
        //
        // }
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
        //   "1",
        // );

      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _directory = _global_key.directory;
    _phone_number_controller.text = _global_key.user_list[0]["phone"];
    _email_controller.text = _global_key.user_list[0]["email"];
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                                errorText: 'name_error_text1'.tr().toString()),
                            // EmailValidator(
                            //     errorText: 'Invalid username format'),
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
                                    .toString()),
                            // EmailValidator(
                            //     errorText: 'Invalid username format'),
                          ]),
                          decoration: InputDecoration(
                            // filled: true,
                            // fillColor: Colors.white70,
                            labelText: 'identification_number'.tr().toString(),
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
                          enabled: false,
                          //keyboardType: TextInputType.text,
                          //autovalidate: true,
                          // validator: MultiValidator([
                          //   RequiredValidator(errorText: 'Please fill in name'),
                          //   // EmailValidator(
                          //   //     errorText: 'Invalid username format'),
                          // ]),
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
                          controller: _email_controller,
                          enabled: false,
                          //keyboardType: TextInputType.text,
                          //autovalidate: true,
                          // validator: MultiValidator([
                          //   RequiredValidator(errorText: 'Please fill in name'),
                          //   // EmailValidator(
                          //   //     errorText: 'Invalid username format'),
                          // ]),
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
                      //Emergency Contact Part
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 15, 0, 10),
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
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
                            child: TextFormField(
                              controller: _contact_name_controller,
                              keyboardType: TextInputType.text,
                              autovalidate: true,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'contact_name_error_text1'
                                        .tr()
                                        .toString()),
                              ]),
                              decoration: InputDecoration(
                                labelText: 'contact_name'.tr().toString(),
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
                            margin: EdgeInsets.fromLTRB(18, 15, 18, 0),
                            child: TextFormField(
                              controller: _contact_number_controller,
                              keyboardType: TextInputType.phone,
                              autovalidate: true,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'contact_number_error_text1'
                                        .tr()
                                        .toString()),
                              ]),
                              decoration: InputDecoration(
                                // filled: true,
                                // fillColor: Colors.white70,
                                labelText: 'contact_number'.tr().toString(),
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
                            //height: 75,
                            // color: Colors.green,
                            margin: EdgeInsets.fromLTRB(18, 15, 18, 10),
                            child: TextFormField(
                              controller: _contact_relationship_controller,
                              keyboardType: TextInputType.text,
                              autovalidate: true,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'relationship_error_text1'
                                        .tr()
                                        .toString()),
                              ]),
                              decoration: InputDecoration(
                                labelText: 'relationship'.tr().toString(),
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
                        ],
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
                              if (_form_key.currentState.validate() &&
                                  _gender != null &&
                                  _identification_type != null) {
                                _update_user_profile();
                                //need to update to online database when click on done
                              }
                              // if the any input is failed, process this
                              else {
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
    );
  }
}

class Photo_State extends StatefulWidget {
  @override
  _Photo_State_State createState() => _Photo_State_State();
}

class _Photo_State_State extends State<Photo_State> {
  // String _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
