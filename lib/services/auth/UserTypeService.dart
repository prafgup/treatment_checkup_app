import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class UserTypeService{

  static final UserTypeService _singleton = UserTypeService._internal();
  factory UserTypeService() {
    return _singleton;
  }
  UserTypeService._internal();




  int userType = -1;

  static String baseUrl = "deleted";

   List<String> setRoleAPI = [
     baseUrl+"/api/trainers/",
     baseUrl+"/api/dieticians/",
     baseUrl+"/api/centers/",
   ];

  List<String> userTypes = [
    'Personal Trainer',
    'Dieticians',
    'Center',
  ];

  Future<void> checkUserType() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = (prefs.getInt('type') ?? -1);
  }

  Future<void> setUserType(int type)async{
    userType = type;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('type',type);
  }

  Future<String> getAuthIdToken() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult authId = await user.getIdToken();
    return "Bearer " +authId.token.toString();
  }

  Future<String> getUID() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String UID = user.uid;
    return UID;
  }




  Future<void> setRole(FirebaseUser user)async{
    await checkUserType();
    if(userType==-1) throw Error();


    String authId  = await getAuthIdToken();
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      'Authorization': authId
    };
    final response = await http.post(
      setRoleAPI[userType]+user.uid.toString(),
    headers: requestHeaders
    );
    if (response.body.split(" ")[0] != "Registered"){
      throw Error();
    }
  }



}


//var map = new Map<String, dynamic>();
//map['UserFullName']=user.displayName;
//map['EmailAddress']=user.email;
//map['AuthorizationPlatform']=type;
//map['AuthorizationToken']=token;
//map['UserDeviceID']=devicetoken;
//
//var loginjsondata = json.encode(map);
//
//final response = await http.post(baseUrl+'login',body: loginjsondata,
//headers: {
//'Content-Type':'application/json'
//}
//);
//
//print(response.body);
//
//if(response.statusCode==200){
//var jsonData = json.decode(response.body);
//String userid  = jsonData['data']["UserID"] ;
//saveuserid(userid);
//return response.statusCode;
//}
//else{
//throw Error();
//}