import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/models/requests.dart';


class RekuestCard extends StatefulWidget {

  final Function press;

  final Request request;
  const RekuestCard({
    Key key,
    this.request,
    this.press,
  }) : super(key: key);

  @override
  _RekuestCardState createState() => _RekuestCardState();
}

class _RekuestCardState extends State<RekuestCard> {
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
                      ),
                      child: Icon(
                        Icons.check_circle_outline_outlined,
                        color: widget.request.status=="Accepted" ? Colors.green :widget.request.status=="Rejected"? Colors.red:Colors.yellow,
                      ),
                    ),
                    SizedBox(width: 10),

                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.request.Relative_name,
                              //type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                             SizedBox(width: constraint.maxWidth*0.3),
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
