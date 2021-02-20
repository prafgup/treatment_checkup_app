import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/models/exercise.dart';
import 'package:treatment_checkup_app/widgets/bottom_nav_bar.dart';
import 'package:treatment_checkup_app/widgets/search_bar.dart';
import 'package:treatment_checkup_app/widgets/session_card.dart';
import 'package:treatment_checkup_app/widgets/radial_progress.dart';

import 'activity_detail.dart';
class DailyScreen extends StatefulWidget {
  @override
  _DailyScreenState createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  int count = 0;
  final List<Exercise> exercises = [
    Exercise(
      image: 'assets/images/image001.jpg',
      title: 'Easy Start',
      time: '5 min',
      difficult: 'Low',
      reps: '5',
      url: 'https://www.youtube.com/watch?v=nskYndiHaA8&ab_channel=HALIDONMUSIC',
      text_instruct:'Keep your back straight and repeat the exercise 5 times ',
    ),
    Exercise(
      image: 'assets/images/image002.jpg',
      title: 'Medium Start',
      time: '10 min',
      difficult: 'Medium',
      reps: '5',
    ),
    Exercise(
      image: 'assets/images/image003.jpg',
      title: 'Pro Start',
      time: '25 min',
      difficult: 'High',
      reps: '5',
    )
  ];
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
                      child:RadialProgress(
                        width: size.width * 0.4,
                        height: size.width * 0.4,
                        progress: 0.6,
                      ),
                    ),

                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: <Widget>[
                        SeassionCard(
                          seassionNum: 1,
                          isDone: true,
                          type: 1,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return ActivityDetail(
                                    exercise: exercises[0],
                                    tag: 'imageHeader$count',
                                  );
                                },
                              ),
                            );

                          },
                        ),
                        SeassionCard(type: 1,
                          seassionNum: 2,
                          press: () {},
                        ),
                        SeassionCard(type: 1,
                          seassionNum: 3,
                          press: () {},
                        ),
                        SeassionCard(type: 1,
                          seassionNum: 4,
                          press: () {},
                        ),
                        SeassionCard(type: 1,
                          seassionNum: 5,
                          press: () {},
                        ),
                        SeassionCard(type: 1,
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
