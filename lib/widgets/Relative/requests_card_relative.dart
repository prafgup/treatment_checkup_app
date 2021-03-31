import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/models/exercise.dart';
import 'package:treatment_checkup_app/models/requests_relative.dart';
import 'package:treatment_checkup_app/screens/Relative/relative_home.dart';


class RekuestsCardRelative extends StatefulWidget {

  final Function press;
  final List<Exercise> exercises;
  final RequestRelative request;
  const RekuestsCardRelative({
    Key key,
    this.exercises,
    this.request,
    this.press,
  }) : super(key: key);

  @override
  _RekuestsCardRelativeState createState() => _RekuestsCardRelativeState();
}

class _RekuestsCardRelativeState extends State<RekuestsCardRelative> {
 
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),

        child: Container(

          width: constraint.maxWidth / 2 -
              10,
          // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            //border: Border.all(color: kBlueColor),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: kShadowColor,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.press,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(

                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: Colors.white ,
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlueColor),
                        image: DecorationImage(
                          image: AssetImage(widget.request.image),
                          fit: BoxFit.fill,

                        ),
                      ),
                      // child: Image(
                      //   image: AssetImage(widget.request.image),
                      //   fit: BoxFit.fill,
                      //
                      // ),
                      // child: Icon(
                      //   Icons.person,
                      //  // color: widget.request.status=="Accepted" ? Colors.green :widget.request.status=="Rejected"? Colors.red:Colors.yellow,
                      // ),
                    ),
                    SizedBox(width: 10),

                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.request.Patient_name,
                                //type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                            //  SizedBox(width: constraint.maxWidth*0.2),
                              //display buttton if no action else display result
                             widget.request.status=="No Action"? Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){showDialog(context: context,
                                        builder: (BuildContext context){
                                          return CustomDialogBox(
                                            title: "Please select all completed exercises:",
                                         //   descriptions: "If you press Yes, exercise will be marked done and cannot be changed later!",
                                            text: "Proceed",
                                              exercises:widget.exercises
                                          );
                                        }
                                    );},
                                    child: Container(

                                      height: 42,
                                      width: 60,alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlueAccent,//request.status=="Accepted" ? Colors.green :request.status=="Rejected"? Colors.red:Colors.yellow,
                                        // shape: BoxShape.values[],
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        //border: Border.all(color: kBlueColor),
                                      ),
                                      child: Text(
                                        "Accept",
                                        // type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                    ),
                                  ),SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: (){showDialog(context: context,
                                        builder: (BuildContext context){
                                          return CustomDialogBox(
                                            title: "Do you wish to reject the request?",
                                           // descriptions: "If you press Yes, exercise will be marked not done and cannot be changed later!",
                                            text: "Yes",

                                          );
                                        }
                                    );},
                                    child: Container(
                                      height: 42,
                                      width: 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrangeAccent,//request.status=="Accepted" ? Colors.green :request.status=="Rejected"? Colors.red:Colors.yellow,
                                        // shape: BoxShape.values[],
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        //border: Border.all(color: kBlueColor),
                                      ),
                                      child: Text(
                                        "Reject",
                                        // type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                    ),
                                  )
                                ],
                              ):
                             Row(
                               children: [
                                 Container(
                                   height: 42,
                                   width: 43,
                                   decoration: BoxDecoration(
                                     color: Colors.white,//request.status=="Accepted" ? Colors.green :request.status=="Rejected"? Colors.red:Colors.yellow,
                                     shape: BoxShape.circle,
                                     //border: Border.all(color: kBlueColor),
                                   ),
                                   child: Icon(
                                     widget.request.status=="Accepted" ? Icons.mark_chat_read :widget.request.status=="Rejected"? Icons.mark_chat_read:Icons.mark_chat_unread,
                                     color: widget.request.status=="Accepted" ? Colors.green :widget.request.status=="Rejected"? Colors.red:Colors.yellow,
                                   ),
                                 ),//SizedBox(width: 20),
                                 Text(
                                   widget.request.status,
                                   //type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                                   style: Theme.of(context).textTheme.subtitle,
                                 ),
                               ],
                             ),

                            ],
                          ),
                          Text(
                            widget.request.date,

                            // type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}




//custom dialoge box.




class CustomDialogBox extends StatefulWidget {
  final String title,  text;
  final Image img;
 final List<Exercise> exercises;
  const CustomDialogBox({Key key, this.title,  this.text, this.img, this.exercises}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  List<String> selectedList = [];
  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
         // margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(color: Colors.grey,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              if(widget.exercises != null)CheckboxListTile(
                 title: Text("Select All"),
                 secondary:Icon(Icons.select_all),
                 activeColor: Colors.green,
                 checkColor: Colors.purple,

                 value: selectedList.length==exercises.length, onChanged:
                 (bool value){
               setState(() {
                 if(value){
    for (int b = 0; b < exercises.length; b++) {
                if (!selectedList.contains(exercises[b].title))   selectedList.add(exercises[b].title);}
                 }
                 else{
                   selectedList.clear();
    // for (int b = 0; b < exercises.length; b++) {
    // selectedList.add(exercises[b].title);}
    }
                 }
    );
             }),


              if(widget.exercises != null)ListView.builder(
                 shrinkWrap:  true ,
                 itemCount: widget.exercises.length,

                itemBuilder:     (context,index){
                  List<bool> _checked=List<bool>.filled(widget.exercises.length,false,growable:false);
                  return CheckboxListTile(
                    title: Text(exercises[index].title),
                      secondary:Image( image: AssetImage(exercises[index].image),width: 50.0,height: 50.0,),
                      activeColor: Colors.green,
                      checkColor: Colors.purple,


                      onChanged:  (bool value){
                        setState(() {
                          if(value){
                            selectedList.add(exercises[index].title);
                          }else{
                            selectedList.remove(exercises[index].title);
                          }
                        });
                      },
                    value: selectedList.contains(exercises[index].title),
                  );
                }
             ),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(widget.text,style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
        // Positioned(
        //   left: 20.0,
        //   right: 20.0,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.transparent,
        //     radius: 45,
        //     child: ClipRRect(
        //         borderRadius: BorderRadius.all(Radius.circular(45.0)),
        //         child: Icons.check_circle_rounded
        //         //Image.asset("assets/model.jpeg")
        //     ),
        //   ),
        // ),
      ],
    );
  }
}