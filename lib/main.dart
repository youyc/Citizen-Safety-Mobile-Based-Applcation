import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:project1/screen/language_selection_screen.dart';
import 'package:project1/screen/login_account_screen.dart';
import 'package:project1/screen/input_information_screen.dart';
import 'package:project1/screen/forgot_account_screen.dart';
import 'package:project1/screen/register_account_screen.dart';
import 'package:project1/screen/home_screen.dart';
import 'package:project1/screen/add_emergency_message.dart';
import 'package:project1/screen/location_screen.dart';
import 'package:project1/screen/profile_screen.dart';
import 'package:project1/screen/profile_input_personal_information_screen.dart';

void main() => runApp(
      EasyLocalization(
        child: My_App(),
        supportedLocales: [Locale("en", "US"), Locale("ms", "MY")],
        path: "asset/translation",
        fallbackLocale: Locale("en", "US"),
        saveLocale: true,
      ),
    );

class My_App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Start Up',
      routes: <String, WidgetBuilder>{
        "/LanguageSelectionScreen": (BuildContext context) =>
            Language_Selection_Screen(),
        "/LoginAccountScreen": (BuildContext context) => Login_Account_Screen(),
        "/InputInformationScreen": (BuildContext context) =>
            Input_Information_Screen(),
        "/ForgotAccountScreen": (BuildContext context) =>
            Forgot_Account_Screen(),
        "/RegisterAccountScreen": (BuildContext context) =>
            Register_Account_Screen(),
        "/HomeScreen": (BuildContext context) => Home_Screen(),
        "/AddEmergencyMessageScreen": (BuildContext context) =>
            Add_Emergency_Message_Screen(),
        "/LocationScreen": (BuildContext context) => Location_Screen(),
        "/ProfileScreen": (BuildContext context) => Profile_Screen(),
        "/ProfileInputPersonalInformationScreen": (BuildContext context) =>
            Profile_Input_Personal_Information_Screen(),

        // "/DetailScreen": (BuildContext context) => Detail_Screen(
        //       value: book_list,
        //       index: book_selected_index,
        //     ),
      },
      home: Language_Selection_Screen(),
    );
  }
}
