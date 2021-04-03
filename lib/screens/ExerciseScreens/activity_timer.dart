import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:treatment_checkup_app/models/exercise.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/daily_layout.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/weekly_layout.dart';
import 'package:treatment_checkup_app/widgets/game_screen/game_screen.dart';

import 'video_player.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ActivityTimer extends StatelessWidget {
  final List<Exercise> exercises;
  final int index;
  final String image =
    'https://www.verywellhealth.com/thmb/Jz6oLND-JaSfigh7oNu8ylHl-HY=/1500x1000/filters:no_upscale():max_bytes(150000):strip_icc()/Verywell-01-2696480-Dorisflexion-598ca2a40d327a0010eb724e.gif';
  final String tag = 'imageHeader';
  ActivityTimer({
    @required this.exercises,
    @required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: OrientationBuilder(builder: (context, orientation) {
          return (MediaQuery.of(context).orientation ==
              prefix0.Orientation.portrait)
              ? Portrait(image: this.image, tag: this.tag,exercises: this.exercises,index:this.index)
              : Landscape(image: this.exercises[this.index].image, tag: this.tag,exercises: this.exercises,index:this.index);
        }),
      ),
    );
  }
}

class Portrait extends StatelessWidget {
  final FlutterTts textsespeech =FlutterTts();
  final String image, tag;
 final List<Exercise> exercises;
 final int index;
  Portrait({@required this.image, @required this.tag, @required this.exercises,@required this.index});

  @override
  Widget build(BuildContext context) {
    final FlutterTts textsespeech =FlutterTts();
    @override
    Future _speak() async{

      await textsespeech.setLanguage("en-US");
      await textsespeech.setSpeechRate(0.7);
      await textsespeech.setPitch(1);

     await textsespeech.speak(this.exercises[this.index].text_instruct);
    }
    var size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Hero(
              tag: this.tag,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 270,
                child: Image.network(
                  this.image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: Column(
                children: [
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                      child: Icon(
                        Icons.videocam_outlined,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                    onTap: () {  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return VideoPlayer(exercise: this.exercises[this.index],);
                      }),
                    );
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                      child: Icon(
                        Icons.record_voice_over,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                    onTap: (){  _speak(); }
                    )


                ],
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
          height: size.height - 270.0,
          width: size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      this.exercises[this.index].title,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                  this.index!=exercises.length-1? 'Next:'+ this.exercises[this.index+1].title:' Next : Questionnaire ',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CircularPercentIndicator(
                      radius: size.width * 0.60,
                      animation: true,
                      animationDuration: 1200,
                      lineWidth: 16.0,
                      percent: 1.00,
                      center: new Text(
                       'X'+ this.exercises[this.index].reps,
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey[400],
                        ),
                      ),
                      backgroundColor: Colors.grey[300],
                      circularStrokeCap: CircularStrokeCap.round,
                      linearGradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(190, 130, 255, 1.0),
                          Color.fromRGBO(105, 139, 255, 1.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) {
                          return this.index!=0?ActivityTimer(exercises: this.exercises, index: this.index-1) : DetailsScreen(); //TODO
                        }),
                      );
                    },
                    child: Container(
                      width: 80.0,
                      height: 55.0,
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(232, 242, 248, 1.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: Color.fromRGBO(82, 126, 255, 1.0),
                        size: 35.0,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) {
                          return this.index!=exercises.length-1?ActivityTimer(exercises: this.exercises, index: this.index+1):GameScreen();
                        }),
                      );
                    },
                    child: Container(
                      width: size.width - 130.0,
                      height: 55.0,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(232, 242, 248, 1.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Color.fromRGBO(82, 126, 255, 1.0),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Landscape extends StatelessWidget {
  final String image, tag;
final List<Exercise> exercises; final int index;
  Landscape({@required this.image, @required this.tag,@required this.exercises,@required this.index});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          child: Image.network(
            this.image,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 40.0,
          left: 40.0,
          child: Text(
            'Plank',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w900,
              color: Colors.grey[500],
            ),
          ),
        ),
        Positioned(
          top: 80.0,
          left: 40.0,
          child: Text(
            'Next: Push-ups',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
              color: Colors.grey[800],
            ),
          ),
        ),
        Positioned(
            top: 30.0,
            left: size.width - 60.0,
            child: GestureDetector(
                child: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 29.0,
                      color: Colors.grey[600],
                    )),
                onTap: () {
                  Navigator.pop(context);
                })),
        Positioned(
            left: 40.0,
            top: size.height - 60.0,
            child: Text(
              '5',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w900,
                color: Colors.grey[500],
              ),
            )),
        Positioned(
            top: size.height - 80.0,
            left: size.width / 2 - 30.0,
            child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.pause,
                  size: 38.0,
                ))),
        Positioned(
          top: size.height - 80.0,
          left: size.width - 170.0,
          child: Container(
            height: 60.0,
            width: 145.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(360.0),
            ),
            child: Center(
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
