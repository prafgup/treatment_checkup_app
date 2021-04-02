import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/models/exercise.dart';
import 'package:treatment_checkup_app/models/requests_relative.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/daily_layout.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
import 'package:treatment_checkup_app/widgets/bottom_nav_bar.dart';
import 'package:treatment_checkup_app/widgets/Relative/bottom_nav_bar_relative.dart';
import 'package:treatment_checkup_app/widgets/request_card.dart';
import 'package:treatment_checkup_app/widgets/Relative/requests_card_relative.dart';
import 'package:treatment_checkup_app/widgets/search_bar.dart';
import 'package:treatment_checkup_app/widgets/session_card.dart';
import 'package:treatment_checkup_app/widgets/radial_progress.dart';
import 'package:treatment_checkup_app/models/requests.dart';




//TODO GET API DATA


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

//type denotes day or week 1 for day and 0 for week

final List<RequestRelative> requests= [
  RequestRelative(
    Patient_name: 'Anshul',
    status: 'No Action',
    date: 'yesterday',
    image: 'assets/images/Dylan.jpg',
    url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',

  ),
  RequestRelative(
    Patient_name: 'Sanskar',
    status: 'No Action',
    date: 'yesterday',
    image: 'assets/images/Thomas.jpg',
    url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',

  ),
  RequestRelative(
    Patient_name: 'Anshul',
    status: 'Rejected',
    date: '7th march',
    image: 'assets/images/Dylan.jpg',
    url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',

  ),
  RequestRelative(
    Patient_name: 'Sanskar',
    status: 'Accepted',
    date: '7th March',
    image: 'assets/images/Thomas.jpg',
    url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',

  ),

];






class RequestsScreenR extends StatefulWidget {


  @override
  _RequestsScreenRState createState() => _RequestsScreenRState();
}

class _RequestsScreenRState extends State<RequestsScreenR> {

  bool isLoading;
  UserTypeService userService;
  var grp_list;
  Future<void> _getRelativeExerciseRequests() async {
    setState(() {
      isLoading = true;
    });
    List<RExerciseRequest> req_list = await userService.GetRelativeExerciseRequests();
     grp_list=groupBy(req_list, (RExerciseRequest req) {
      return '${req.todayDay}+${req.patientId}';
    }).values.toList();

    print(grp_list);

    setState(() {
      isLoading = false;
    });
    return grp_list;
  }
  @override
  void initState() {
    super.initState();
    isLoading = false;
    userService = UserTypeService();
    _getRelativeExerciseRequests().catchError((e){
      setState(() {
        isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBarR(active_icon: [false,true,false],),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .18,
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
                      height: size.height * 0.03,
                    ),
                    Text(
                      "Requests",
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    SizedBox(
                      height: size.height*0.75,

                      child: isLoading == true? Container(
                          color: Colors.black.withOpacity(0.5),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: CircularProgressIndicator(),)):
                      FutureBuilder(future: _getRelativeExerciseRequests(),
                          builder: (context, projectSnap) {
                            if (projectSnap.connectionState == ConnectionState.none &&
                                projectSnap.hasData == null) {
                              //print('project snapshot data is: ${projectSnap.data}');
                              return Container();
                            }
                            return
                      GridView.builder(
                          itemCount: projectSnap.data.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,mainAxisSpacing: 10.0,childAspectRatio:4
                          ),
                          // Generate 100 widgets that display their index in the List.
                          itemBuilder: (ctx, index) {
                            return RekuestsCardRelative(exercises: projectSnap.data[index],request: projectSnap.data[index][0],press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return RequestsScreenR();
                                }),
                              );

                            }, );
                          });})
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

