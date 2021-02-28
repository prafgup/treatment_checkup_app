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
      title: 'Ankle toe movement',
      time: '5 min',
      difficult: 'Low',
      reps: '25',
      url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',
      text_instruct:'Do this exercise regularly to reduce swelling. Follow the Video in real-time and repeat what she does on the screen',
    ),
    Exercise(
      image: 'assets/images/image004.jpg',
      title: 'Isometric Quads',
      time: '10 min',
      difficult: 'Medium',
      reps: '10',
      url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',
      text_instruct:'Do this exercise regularly to reduce swelling. Follow the Video in real-time and repeat what she does on the screen',
    ),
    Exercise(
      image: 'assets/images/image003.jpg',
      title: 'Quadriceps Sets',
      time: '10 min',
      difficult: 'Medium',
      reps: '20',
      url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',
      text_instruct:'Do this exercise regularly to reduce swelling. Follow the Video in real-time and repeat what she does on the screen',
    ),

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
                        progress: 0.6,type: 1.0,
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.5,
                      child: GridView.count(
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: 2,mainAxisSpacing: 10.0,childAspectRatio:3 ,
                        shrinkWrap: true,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(7, (index) {
                          return SeassionCard(seassionNum:index+1, isDone:index<2?true:false,type: 1,press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) {
                                  return ActivityDetail(
                                    exercises: exercises,
                                    tag: 'imageHeader$count',
                                  );
                                },
                              ),
                            );
                          }, );
                        }),
                      ),
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
