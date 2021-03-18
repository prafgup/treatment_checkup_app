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
  MyProfileUpdated myProfileUpdated;


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
      "first_name" : firstName,
      "last_name" : lastName
    };
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    print("sending req");
    var response;
    try{
      response = await http.post(
        registerAPI[0],
        body: requestBody,
        headers: requestHeaders
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
      "first_name" : firstName,
      "last_name" : lastName
    };
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    print("sending req");
    var response;
    try{
      response = await http.post(
        registerAPI[1],
        body: requestBody,
        headers: requestHeaders
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

  Future<MyProfileUpdated> getMyProfileData()async{


    if(myProfileUpdated != null){
      print("exists");
      print(myProfileUpdated.toJson());
      return MyProfileUpdated.fromJson(myProfileUpdated.toJson());
    }
    await checkUserType();
    if(userType==-1) throw Error();
    await checkJWTToken();


    print("sending req");
    var response;
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      'x-access-token': jwtToken
    };
    try{
      response = await http.get(
        baseUrl + '/api/v1/profile/get' ,
        headers: requestHeaders
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 200){
      print("Got Profile");
      Map<String, dynamic> myObj = json.decode(response.body);
      myProfileUpdated = myObj['profile'] != null
          ? new MyProfileUpdated.fromJson(myObj['profile'])
          : new MyProfileUpdated.fromJson({});

      print(myProfileUpdated.toJson());
    }else {
      print("Error in response");
      print(response.body);
      throw new Error();
    }
    print(response.body);
    print(response.statusCode);
    return MyProfileUpdated.fromJson(myProfileUpdated.toJson());

  }

  Future<MyProfileUpdated> updateMyProfileData(MyProfileUpdated updateQueryProfile)async{

    await checkUserType();
    if(userType==-1) throw Error();
    await checkJWTToken();


    print("sending req");
    var response;
    Map<String, String> requestHeaders = {
      'x-access-token': jwtToken
    };
    try{
      print("encoded val is ");
      print( json.encode(updateQueryProfile.toJson()));
      response = await http.post(
          baseUrl + '/api/v1/profile/update' ,
          headers: requestHeaders,
          body: updateQueryProfile.toJson()
      );
    }
    catch(e){
      print(e);
    }
    if(response.statusCode == 200){
      print("Got Profile");
      Map<String, dynamic> myObj = json.decode(response.body);
      myProfileUpdated = myObj['myProfileUpdated'] != null
          ? new MyProfileUpdated.fromJson(myObj['myProfileUpdated'])
          : new MyProfileUpdated.fromJson({});

      print(myProfileUpdated.toJson());
    }else {
      print("Error in response");
      print(response.body);
      throw new Error();
    }
    print(response.body);
    print(response.statusCode);

    return MyProfileUpdated.fromJson(myProfileUpdated.toJson());

  }


}

class MyProfileUpdated {
  String userId;
  String firstName;
  String lastName;
  String dob;
  String profilePic;
  String homeAddress;
  String emailId;
  String createdDate;
  String modifiedDate;

  MyProfileUpdated(
      {this.userId,
        this.firstName,
        this.lastName,
        this.dob,
        this.profilePic,
        this.homeAddress,
        this.emailId,
        this.createdDate,
        this.modifiedDate});

  MyProfileUpdated.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'] == null ? "" : json['user_id'];
    firstName = json['first_name'] == null ? "" : json['first_name'];
    lastName = json['last_name'] == null ? "" : json['last_name'];
    dob = json['dob'] == null ? "" : json['dob'];
    profilePic = json['profile_pic'] == null ? "" : json['profile_pic'];
    homeAddress = json['home_address'] == null ? "" : json['home_address'];
    emailId = json['email_id'] == null ? "" : json['email_id'];
    createdDate = json['created_date'] == null ? "" : json['created_date'];
    modifiedDate = json['modified_date'] == null ? "" : json['modified_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['user_id'] = this.userId == null ? "" : this.userId;
    data['first_name'] = this.firstName == null ? "" : this.firstName;
    data['last_name'] = this.lastName == null ? "" : this.lastName;
    data['dob'] = this.dob == null ? "" : this.dob;
    data['profile_pic'] = this.profilePic == null ? "" : this.profilePic;
    data['home_address'] = this.homeAddress == null ? "" : this.homeAddress;
    data['email_id'] = this.emailId == null ? "" : this.emailId;
    data['created_date'] = this.createdDate == null ? "" : this.createdDate;
    data['modified_date'] = this.modifiedDate == null ? "" : this.modifiedDate;
    return data;
  }
}