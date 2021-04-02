import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:treatment_checkup_app/services/auth/FirebaseUser.dart';
import '../../services/auth/UserTypeService.dart';import 'package:treatment_checkup_app/screens/Relative/relative_home.dart';
import 'package:treatment_checkup_app/screens/ExerciseScreens/weekly_layout.dart';
class ProfilePageP extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePageP>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  bool _isLoading = false;
  final FocusNode myFocusNode = FocusNode();
  final TextEditingController _userNameFirst = new TextEditingController();
  final TextEditingController _userNameSecond = new TextEditingController();
  final TextEditingController _emailId = new TextEditingController();
  final TextEditingController _mobileNumber = new TextEditingController();
  final TextEditingController _dob = new TextEditingController();
  final TextEditingController _address = new TextEditingController();
  final TextEditingController _pinCode = new TextEditingController();
  final TextEditingController _city = new TextEditingController();
  String _profilePic = "";
  UserTypeService userService;
  MyProfileUpdated myProfileUpdated;

  @override
  void initState() {
    _isLoading = true;
    userService = UserTypeService();
    getMyProfile();
    super.initState();
  }


  Future<void> getMyProfile() async {

    myProfileUpdated = await userService.getMyProfileData();
    _userNameFirst.text  = myProfileUpdated.firstName;
    _userNameSecond.text = myProfileUpdated.lastName;
    _emailId.text = myProfileUpdated.emailId;
    _dob.text = myProfileUpdated.dob.length == 0 ? "" : DateFormat.yMMMd().format(DateTime.parse(myProfileUpdated.dob));
    _address.text = myProfileUpdated.homeAddress;
    _pinCode.text = myProfileUpdated.lastName;
    _city.text = myProfileUpdated.lastName;

    setState(() {
      _isLoading = false;
    });

  }

  Future<void> saveProfile() async {
    setState(() {
      _isLoading = true;
    });

    myProfileUpdated.firstName = _userNameFirst.text;
    myProfileUpdated.firstName = _userNameFirst.text  ;
    myProfileUpdated.lastName = _userNameSecond.text ;
    myProfileUpdated.emailId = _emailId.text ;
    print(_dob.text);
    myProfileUpdated.dob = _dob.text.length == 0 ? "" : DateFormat("MMM dd, yyyy").parseUTC(_dob.text).toIso8601String() ;
    myProfileUpdated.homeAddress = _address.text ;
//    myProfileUpdated.lastName = _pinCode.text ;
//    myProfileUpdated.lastName = _city.text ;


    myProfileUpdated = await userService.updateMyProfileData(myProfileUpdated);


    setState(() {
      _isLoading = false;
    });

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.white,
              child: new ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Container(
                        height: 250.0,
                        color: Colors.white,
                        child: new Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                                child: new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                      size: 22.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: new Text("Profile",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 30,right: 0,top: 0,bottom: 0),
                                      child: RaisedButton(
                                        onPressed: () async {
                                          // await ;

                                            int x= await userService.userType;
                                      if(x==0) {

                                        userService.setUserType(1);
                                      Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>RequestsScreenR()));

                                      }
                                      else {
                                        userService.setUserType(0);
                                        Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> DetailsScreen()));

                                      }
                                        },
                                        elevation: 5,
                                        color: Color.fromRGBO(108, 71, 145, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),

                                        ),
                                        child: Text(

                                          userService.userType==0?"Switch to Relative":"Switch to Patient",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20,right: 0,top: 0,bottom: 0),
                                      child: RaisedButton(
                                        onPressed: () async {
                                          await FirebaseSignInService().signOut(context);
                                        },
                                        elevation: 5,
                                        color: Color.fromRGBO(108, 71, 145, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),

                                        ),
                                        child: Text("LOGOUT",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: new Stack(fit: StackFit.loose, children: <Widget>[
                                new Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Container(
                                        width: 140.0,
                                        height: 140.0,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            image: new ExactAssetImage(
                                                'assets/images/Dylan.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new CircleAvatar(
                                          backgroundColor: Colors.deepPurpleAccent,
                                          radius: 25.0,
                                          child: new Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    )),
                              ]),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        color: Color(0xffFFFFFF),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 25.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Personal Information',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _status ? _getEditIcon() : new Container(),
                                        ],
                                      )
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: new Text(
                                            'First Name',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: new Text(
                                            'Last Name',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: new TextField(
                                            controller: _userNameFirst,
                                            decoration: const InputDecoration(
                                                hintText: "Enter First Name"),
                                            enabled: !_status,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: new TextField(
                                          controller: _userNameSecond,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Last Name"),
                                          enabled: !_status,
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),

                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Date of Birth',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: InkWell(
                                          onTap: (){
                                            if(!_status){
                                              DatePicker.showDatePicker(context,
                                                  onConfirm: (dateTime, List<int> index) {
                                                    print(dateTime.toIso8601String());
                                                  setState(() {
                                                    _dob.text = DateFormat.yMMMd().format(dateTime);
                                                    print("changed to " + _dob.text);
                                                  });
                                                  },
                                                  onClose: () => print("----- onClose -----"),
                                                  onCancel: () => print('onCancel'),
                                                  onChange: (dateTime, List<int> index) {
                                                    setState(() {
                                                      print('onChange');
                                                    });
                                                  },
                                                  maxDateTime: DateTime.now()
                                              );
                                            }

                                          },
                                          child: new TextField(
                                            controller : _dob,
                                            decoration: const InputDecoration(hintText: "Enter Date of Birth"),
                                            enabled: false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Email ID',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller : _emailId,
                                          decoration: const InputDecoration(
                                              hintText: "Enter Email ID"),
                                          enabled: !_status,
                                        ),
                                      ),
                                    ],
                                  )),

                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Address',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextField(
                                          controller : _address,
                                          decoration: const InputDecoration(
                                            hintText: "Enter House no and street information",
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,

                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: new TextField(
                                            controller : _pinCode,
                                            decoration: const InputDecoration(
                                                hintText: "Enter Pincode"),
                                            enabled: !_status,
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: new TextField(
                                          controller : _city,
                                          decoration: const InputDecoration(
                                              hintText: "Enter City"),
                                          enabled: !_status,
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              !_status ? _getActionButtons() : new Container(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            _isLoading == true? Container(
                color: Colors.black.withOpacity(0.5),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(child: CircularProgressIndicator(),)):Container(),
          ],
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () async {
                      try{
                        await saveProfile();
                        setState(() {
                          _status = true;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      }
                      catch(e){
                        print(e);
                        print("failed to update");
                      }

                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.deepPurpleAccent,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}