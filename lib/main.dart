import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:treatment_checkup_app/screens/otpVerify/otpEnter.dart';
//import 'package:treatment_checkup_app/screens/personalTrainerApp/homePagePersonalTrainer.dart';
import 'package:treatment_checkup_app/screens/splashScreen/splashScreen.dart';
import 'package:treatment_checkup_app/screens/trainingCenters/pricingRevenue/pricingAndRevenue.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/weekly_layout.dart';
import 'package:treatment_checkup_app/screens/welcomeBoarding/welcomeBoarding.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:treatment_checkup_app/services/auth/FirebaseUser.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:treatment_checkup_app/screens/registerUsers/registerPatient.dart';
main() {
  runApp(
      RestartWidget(
        child: MaterialApp(
          supportedLocales: const <Locale>[
            Locale('en', ''),
          ],
            debugShowCheckedModeBanner: false,
            home: TreatmentPartner(),
        ),
      )
  );
}



class TreatmentPartner extends StatefulWidget {
  @override
  _TreatmentPartnerState createState() => _TreatmentPartnerState();
}

class _TreatmentPartnerState extends State<TreatmentPartner> {
  final userService = new UserTypeService();
  final firebaseCheckService= new FirebaseSignInService();


  void _checkAppType(){



    print("inside " + userService.userType.toString() +"   "+ firebaseCheckService.user.toString());

    if((userService.userType == -1) || (firebaseCheckService.user == null) || ((userService.userRegistered == -1)) || ((userService.jwtToken == ""))){
    //Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> RegisterPatientRelative()));
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> WelcomeBoarding()));
    }
    else if((userService.userType ==0) && (firebaseCheckService.user != null)){  // patient
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> DetailsScreen()));
    }
    else if((userService.userType ==1) && (firebaseCheckService.user != null)){   // relative
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> DetailsScreen())); //todo
    }
    else{
      print("Push Failed");
    }


  }
  
  @override
  void initState() {
    userService.checkUserType();
    userService.checkUserRegistered();
    userService.checkJWTToken();
    firebaseCheckService.checkLogin();

    Timer(Duration(seconds: 3), _checkAppType);  //TODO
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}



class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

