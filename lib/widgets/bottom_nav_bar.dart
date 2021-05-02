import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:treatment_checkup_app/Localization/localization_constant.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/patient_profile.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/weekly_layout.dart';
import 'package:treatment_checkup_app/screens/Requests_screen/patients_request_screen.dart';
import 'package:treatment_checkup_app/screens/personalTrainerApp/account/AccountHome.dart';


class BottomNavBar extends StatefulWidget {
  final List<bool> active_icon;
  const BottomNavBar({
    Key key,
    this.active_icon,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            isActive: widget.active_icon[0],
            title: getTranslated(context, "requests"),
            svgScr: "assets/icons/calendar.svg",
            press: () {
              if(!widget.active_icon[0])Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return RequestsScreenP();
                }),
              );

            },
          ),
          BottomNavItem(
            isActive: widget.active_icon[1],
            title:getTranslated(context,  "all_exercises"),
            svgScr: "assets/icons/gym.svg",

            press: () {
              if(!widget.active_icon[1])Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return DetailsScreen();
                }),
              );

            },
          ),
          BottomNavItem(
            isActive: widget.active_icon[2],
            title: getTranslated(context, "settings"),
            svgScr: "assets/icons/Settings.svg",
            press: () {
              if(!widget.active_icon[2])Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ProfilePageP();
                }),
              );

            },
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String svgScr;
  final String title;
  final Function press;
  final bool isActive;
  const BottomNavItem({
    Key key,
    this.svgScr,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(
            svgScr,
            color: isActive ? kActiveIconColor : kTextColor,
            fit: BoxFit.contain,
          ),
          Text(
            title,
            style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
          ),
        ],
      ),
    );
  }
}
