import 'package:flutter/material.dart';

import 'package:toast/toast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class Forgot_Account_Screen extends StatefulWidget {
  @override
  _Forgot_Account_ScreenState createState() => _Forgot_Account_ScreenState();
}

class _Forgot_Account_ScreenState extends State<Forgot_Account_Screen> {
  TextEditingController _username_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  GlobalKey<FormState> _form_key = GlobalKey<FormState>();

  void _change_password() async {
    String _username = _username_controller.text;
    String _password = _password_controller.text;

    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Registration...");
    await pr.show();
    http.post("http://icebeary.com/safety/php/PHPMailer/change_password.php",
        body: {
          "username": _username,
          "password": _password,
        }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "An email has been sent to ${_username}'s email. Please check your email for password chaging verification. Also check in your spam folder.",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
        Navigator.of(context).pushReplacementNamed("/LoginAccountScreen");
      } else {
        Toast.show(
          "No registered username",
          context,
          duration: 4,
          gravity: Toast.BOTTOM,
        );
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
                        //lowerpart
                        Container(
                          //height: _screen_height - (_screen_height / 2),
                          //color: Colors.amberAccent,
                          child: Column(
                            children: [
                              Container(
                                //height: 90,
                                // color: Colors.green,
                                margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                                child: TextFormField(
                                  controller: _username_controller,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidate: true,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "username_error_text1"
                                            .tr()
                                            .toString()),
                                    MinLengthValidator(5,
                                        errorText: "username_error_text2"
                                            .tr()
                                            .toString()),
                                  ]),
                                  decoration: InputDecoration(
                                    labelText: "username".tr().toString(),
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
                                //height: 90,
                                // color: Colors.green,
                                margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                                child: TextFormField(
                                  controller: _password_controller,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidate: true,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "password_error_text1"
                                            .tr()
                                            .toString()),
                                    MinLengthValidator(5,
                                        errorText: "password_error_text2"
                                            .tr()
                                            .toString()),
                                  ]),
                                  decoration: InputDecoration(
                                    labelText: "new_password".tr().toString(),
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
                                  child: RaisedButton(
                                    color: Colors.green[800],
                                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    onPressed: () {
                                      //if the 2 input are corect, process this
                                      if (_form_key.currentState.validate()) {
                                        _change_password();
                                      }
                                      // if the any input is failed, process this
                                      else {
                                        Toast.show(
                                          "Please fill in username and new password",
                                          context,
                                          duration: 4,
                                          gravity: Toast.BOTTOM,
                                        );
                                      }
                                    },
                                    child: Text(
                                      "change_password".tr().toString(),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .pushReplacementNamed(
                                        "/LoginAccountScreen"),
                                child: Text(
                                  "back_to_login_page".tr().toString(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
