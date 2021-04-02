import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/models/exercise.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'package:treatment_checkup_app/widgets/bottom_nav_bar.dart';
import 'package:treatment_checkup_app/widgets/search_bar.dart';
import 'package:treatment_checkup_app/widgets/session_card.dart';
import 'package:treatment_checkup_app/widgets/radial_progress.dart';

import 'activity_detail.dart';
class DailyScreen extends StatefulWidget {
  final int weekNumber;
  DailyScreen(this.weekNumber);
  @override
  _DailyScreenState createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  int count = 0;
  bool isLoading = true;
  UserTypeService userService;
  List<TreatmentDayData> allDayExercises = [];

  List<List<Exercise>> exercises = [
    [],
    [Exercise(
        day: 1,
        image: 'assets/images/image001.jpg',
        title: 'Ankle toe movement',
        time: '5 min',
        difficult: 'Low',
        reps: '25',
        url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',
        text_instruct:'Do this exercise regularly to reduce swelling. Follow the Video in real-time and repeat what she does on the screen',
        totalTime : "100 min"
    ),
      Exercise(
          day: 1,
          image: 'assets/images/image001.jpg',
          title: 'Ankle toe movement',
          time: '5 min',
          difficult: 'Low',
          reps: '25',
          url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',
          text_instruct:'Do this exercise regularly to reduce swelling. Follow the Video in real-time and repeat what she does on the screen',
          totalTime : "100 min"
      ),
      Exercise(
          day: 1,
          image: 'assets/images/image001.jpg',
          title: 'Ankle toe movement',
          time: '5 min',
          difficult: 'Low',
          reps: '25',
          url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',
          text_instruct:'Do this exercise regularly to reduce swelling. Follow the Video in real-time and repeat what she does on the screen',
          totalTime : "100 min"
      ),
      Exercise(
          day: 1,
          image: 'assets/images/image001.jpg',
          title: 'Ankle toe movement',
          time: '5 min',
          difficult: 'Low',
          reps: '25',
          url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',
          text_instruct:'Do this exercise regularly to reduce swelling. Follow the Video in real-time and repeat what she does on the screen',
          totalTime : "100 min"
      ),
      Exercise(
          day: 1,
          image: 'assets/images/image001.jpg',
          title: 'Ankle toe movement',
          time: '5 min',
          difficult: 'Low',
          reps: '25',
          url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',
          text_instruct:'Do this exercise regularly to reduce swelling. Follow the Video in real-time and repeat what she does on the screen',
          totalTime : "100 min"
      ),],
    [],
    [],
    [],
    [],
    [],
    [],
    []
  ];


  Future<void> getMyWeekProgress() async {

    allDayExercises = await userService.GetPatientWeekExerciseDetails();
    for(int i=0;i<allDayExercises.length;i++){
      if((allDayExercises[i].todayDay-1)/7 != widget.weekNumber-1){
        continue;
      }
      int totalTime =0;
      for(int j=0;j<allDayExercises.length;j++){
        if(allDayExercises[i].todayDay == allDayExercises[j].todayDay){
          totalTime+=allDayExercises[j].duration;
        }
      }

      exercises[(allDayExercises[i].todayDay-1)%7].add(Exercise(
        day: allDayExercises[i].todayDay,
        image: allDayExercises[i].exerciseImgUrl == '' ? 'assets/images/image003.jpg' : allDayExercises[i].exerciseImgUrl,
        title: allDayExercises[i].exerciseName,
        time: allDayExercises[i].duration.toString(),
        difficult: 'Medium',
        reps: allDayExercises[i].exerciseRep.toString(),
        url: allDayExercises[i].exerciseVideoUrl == ''?'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide' : allDayExercises[i].exerciseVideoUrl,
        text_instruct: allDayExercises[i].instructions,
        totalTime: totalTime.toString() +' Min'
      ),);
    }
    setState(() {
      isLoading = false;
    });

  }


  @override
  void initState() {
    isLoading = true;
    userService = UserTypeService();
    getMyWeekProgress();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(active_icon:[false,true,false]),
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
                                    exercises: exercises[index],
                                    tag: 'imageHeader$count',
                                    day : index+1
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
          isLoading == true? Container(
              color: Colors.black.withOpacity(0.5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(child: CircularProgressIndicator(),)):Container(),
        ],
      ),
    );
  }
}
