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
  String jwtToken = "";
  int userRegistered = -1;


  static String baseUrl = "https://treatment-application-dep.herokuapp.com";

   List<String> loginAPI = [
     baseUrl+"/api/v1/users/login",
   ];
  List<String> registerAPI = [
    baseUrl+"/api/v1/register/patient",
    baseUrl+"/api/v1/register/relative",
  ];

  Future<void> setUserRegistered(int status)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('registered',status);
  }

  Future<void> checkUserRegistered() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userRegistered = (prefs.getInt('registered') ?? -1);
  }

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
    return authId.token.toString();
  }

  Future<String> getUID() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;
    return uid;
  }


  Future<void> checkJWTToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jwtToken = (prefs.getString('jwt') ?? "");
    //jwtToken = "";
  }

  Future<void> setJWTToken(String token)async{
    jwtToken = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt',token);
  }


  Future<int> setRole(FirebaseUser user,String mobileNumber)async{
    await checkUserType();
    if(userType==-1) throw Error();

    String authId  = await getAuthIdToken();

    Map<String, String> requestBody = {
      "mobile_number": mobileNumber,
      "user_type" : (userType == 0) ? "p" : "r",
      "auth_token" : authId
    };
    print("sending req");
    var response;
    try{
      response = await http.post(
        loginAPI[0],
        body: requestBody,
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 400){
      print("Error in response");
      print(response.body);
      throw new Error();
    }
    if(response.statusCode == 200){
      setUserRegistered(200);
    }
    await setJWTToken(json.decode(response.body)["token"]);
    print(response.statusCode);
    return response.statusCode;
//    if (response.body.split(" ")[0] != "Registered"){
//      throw Error();
//    }


  }

  Future<int> registerPatient(String firstName, String lastName,String relative1,String relative2)async{
    await checkUserType();
    if(userType==-1) throw Error();

    await checkJWTToken();

    Map<String, String> requestBody = {
      "relative_2": relative2,
      "relative_1" : relative1,
      "x-access-token" : jwtToken,
      "first_name" : firstName,
      "last_name" : lastName
    };
    print("sending req");
    var response;
    try{
      response = await http.post(
        registerAPI[0],
        body: requestBody,
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 400){
      print("Error in response");
      print(response.body);
      throw new Error();
    }
    if(response.statusCode == 200){
      setUserRegistered(200);
    }
    print(response.body);
    print(response.statusCode);
    return response.statusCode;

  }
  Future<int> registerRelative(String firstName, String lastName)async{
    await checkUserType();
    if(userType==-1) throw Error();

    await checkJWTToken();

    Map<String, String> requestBody = {
      "x-access-token" : jwtToken,
      "first_name" : firstName,
      "last_name" : lastName
    };
    print("sending req");
    var response;
    try{
      response = await http.post(
        registerAPI[1],
        body: requestBody,
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 400){
      print("Error in response");
      print(response.body);
      throw new Error();
    }
    if(response.statusCode == 200){
      setUserRegistered(200);
    }
    print(response.body);
    print(response.statusCode);
    return response.statusCode;

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