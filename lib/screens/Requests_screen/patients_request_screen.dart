import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/daily_layout.dart';
import 'package:treatment_checkup_app/widgets/bottom_nav_bar.dart';
import 'package:treatment_checkup_app/widgets/request_card.dart';
import 'package:treatment_checkup_app/widgets/search_bar.dart';
import 'package:treatment_checkup_app/widgets/session_card.dart';
import 'package:treatment_checkup_app/widgets/radial_progress.dart';
import 'package:treatment_checkup_app/models/requests.dart';




//TODO GET API DATA




//type denotes day or week 1 for day and 0 for week

final List<Request> requests= [
  Request(
    Relative_name: 'Anshul',
    status: 'No action',
    date: 'yesterday',
    image: 'Low',
    url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',

  ),
  Request(
    Relative_name: 'Sanskar',
    status: 'Accepted',
    date: 'yesterday',
    image: 'Low',
    url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',

  ),
  Request(
    Relative_name: 'Anshul',
    status: 'Accepted',
    date: '7th march',
    image: 'Low',
    url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',

  ),
  Request(
    Relative_name: 'Sanskar',
    status: 'Accepted',
    date: '7th March',
    image: 'Low',
    url: 'https://www.youtube.com/watch?v=O1jfSo66z44&ab_channel=goodexerciseguide',

  ),

];







class RequestsScreenP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(active_icon: [true,false,false],),
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

                      child: GridView.builder(
                        itemCount: requests.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,mainAxisSpacing: 10.0,childAspectRatio:4
                       ),
                        // Generate 100 widgets that display their index in the List.
                        itemBuilder: (ctx, index) {
                          return RekuestCard(request: requests[index],press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return RequestsScreenP();
                              }),
                            );

                          }, );
                        }),
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

