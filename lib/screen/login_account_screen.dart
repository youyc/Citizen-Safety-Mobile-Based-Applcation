import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import '../global_value.dart';
import '../database.dart';
import '../message.dart';

class Login_Account_Screen extends StatefulWidget {
  @override
  _Login_Account_ScreenState createState() => _Login_Account_ScreenState();
}

class _Login_Account_ScreenState extends State<Login_Account_Screen> {
  TextEditingController _username_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  //key for currentstate, it is used for the email & password input validator
  GlobalKey<FormState> _form_key = GlobalKey<FormState>();
  GlobalState _global_key = GlobalState.instance;
  DB _db = DB.instance;

  void _login_without_save_preferences() async {
    String username = _username_controller.text;
    String password = _password_controller.text;
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Logging In...");
    await pr.show();
    http.post("http://icebeary.com/safety/php/login.php", body: {
      "username": username,
      "password": password,
    }).then((res) {
      print(res.body);
      if (res.body == "failed") {
        Toast.show(
          "No Registed Account",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
      } else {
        var user_jscode = json.decode(res.body);
        _global_key.user_list = user_jscode['user'];
        _global_key.password = password;
        print(_global_key.password);
        _db.insert_useraccount(
          username,
          password,
          _global_key.user_list[0]["phone"],
          _global_key.user_list[0]["email"],
          _global_key.user_list[0]["name"],
          _global_key.user_list[0]["gender"],
          _global_key.user_list[0]["identification_type"],
          _global_key.user_list[0]["identification_number"],
          _global_key.user_list[0]["identification_photo"],
          "0",
        );

        if (_global_key.user_list[0]["name"] == null ||
            _global_key.user_list[0]["gender"] == null ||
            _global_key.user_list[0]["identification_type"] == null ||
            _global_key.user_list[0]["identification_number"] == null) {
          Navigator.of(context).pushReplacementNamed("/InputInformationScreen");
        } else {
          Navigator.of(context).pushReplacementNamed("/HomeScreen");
        }

        // user_list_size = _global_key.user_list.length;
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  @override
  Widget build(BuildContext context) {
    double _screen_height = MediaQuery.of(context).size.height;
    double _screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: true,
        // appBar: AppBar(
        //   title: Text('Material App Bar'),
        // ),
        body: Form(
          key: _form_key,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  //upperpart
                  Container(
                    //height: _screen_height - (_screen_height / 2),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: Image.asset(
                              'asset/image/logo1.png',
                              scale: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //lowerpart
                  Container(
                    //height: _screen_height - (_screen_height / 2),
                    //color: Colors.green[50],
                    child: Column(
                      children: [
                        Container(
                          //height: 75,
                          // color: Colors.green,
                          margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                          child: TextFormField(
                            controller: _username_controller,
                            keyboardType: TextInputType.text,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                      "username_error_text1".tr().toString()),
                              MinLengthValidator(5,
                                  errorText:
                                      "username_error_text2".tr().toString()),
                            ]),
                            decoration: InputDecoration(
                              // filled: true,
                              // fillColor: Colors.white70,
                              labelText: "username".tr().toString(),
                              icon: Icon(
                                Icons.people,
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
                          // height: 75,
                          // color: Colors.green,
                          margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _password_controller,
                            obscureText: true,
                            autovalidate: true,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                      "password_error_text1".tr().toString()),
                              MinLengthValidator(5,
                                  errorText:
                                      "password_error_text2".tr().toString()),
                            ]),
                            decoration: InputDecoration(
                              labelText: "password".tr().toString(),
                              icon: Icon(
                                Icons.lock,
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
                          margin: EdgeInsets.fromLTRB(0, 20, 30, 0),
                          child: Container(
                            width: 170,
                            child: RaisedButton(
                              color: Colors.green[800],
                              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {
                                //if the 2 input are corect, process this
                                if (_form_key.currentState.validate()) {
                                  _login_without_save_preferences();
                                }
                                // if the tany input is failed, process this
                                else {
                                  Toast.show(
                                    "Please fill in username and password",
                                    context,
                                    duration: 4,
                                    gravity: Toast.BOTTOM,
                                  );
                                }
                              },
                              child: Text(
                                "login".tr().toString(),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          margin: EdgeInsets.fromLTRB(0, 0, 30, 20),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed("/ForgotAccountScreen"),
                            child: Text(
                              "forgot_account".tr().toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue[600],
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed("/RegisterAccountScreen"),
                          child: Text(
                            "sign_up".tr().toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
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
        ),
      ),
    );
  }
}
