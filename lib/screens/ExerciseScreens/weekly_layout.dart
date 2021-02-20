import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'file:///C:/Users/ankit/Desktop/DEP/New%20folder/treatment_checkup_app/lib/screens/ExerciseScreens/daily_layout.dart';
import 'package:treatment_checkup_app/widgets/bottom_nav_bar.dart';
import 'package:treatment_checkup_app/widgets/search_bar.dart';
import 'package:treatment_checkup_app/widgets/session_card.dart';
import 'package:treatment_checkup_app/widgets/radial_progress.dart';
class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: kBlueLightColor,
              image: DecorationImage(
                image: AssetImage("assets/images/meditation_bg.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "Exercise",
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "3-10 MIN Course",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .6, // it just take 60% of total width
                      child: Text(
                        "Make your surgery a success by following the exercise schedule daily!!",
                      ),
                    ),
                    SizedBox(
                      width: size.width * .5, // it just take the 50% width
                      // height: size.height*.15
                      // ,
                      child:RadialProgress(
                        width: size.width * 0.4,
                        height: size.width * 0.4
                        ,
                        progress: 0.3,
                      ),
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: <Widget>[
                        SeassionCard(
                          seassionNum: 1,
                          isDone: true,
                          type: 0,

                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return DailyScreen();
                              }),
                            );

                          },
                        ),
                        SeassionCard(type: 0,
                          seassionNum: 2,
                          press: () {},
                        ),
                        SeassionCard(type: 0,
                          seassionNum: 3,
                          press: () {},
                        ),
                        SeassionCard(type: 0,
                          seassionNum: 4,
                          press: () {},
                        ),
                        SeassionCard(type: 0,
                          seassionNum: 5,
                          press: () {},
                        ),
                        SeassionCard(type: 0,
                          seassionNum: 6,
                          press: () {},
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

