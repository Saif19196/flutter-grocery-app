import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:untitled1/config.dart';
import 'package:untitled1/models/customer.dart';
import 'package:untitled1/models/login_model.dart';

class APIService{
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64.encode(utf8.encode(Config.key+":" + Config.sceret),);

    bool ret = false;

    try {
      var response = await Dio().post(
          Config.url + Config.customerUrl, data: model.toJson(),
          options: new Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: "application/json"
          }));
      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch(e){
      if(e.response.statusCode == 404)
        {
          ret = false;
        }
      else{
        ret =false;
      }
    }
    return ret;
  }
  Future<LoginResponseModel> loginCustomer(String username, String password) async{
    late LoginResponseModel model;

    try {
      var response = await Dio().post(
        Config.tokenUrl,data: {
          "username" : username,
        "password" : password,
      },
        options: new Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
          }
        )
      );
      if(response.statusCode ==200) {
        model =LoginResponseModel.fromJson(response.data);
      }
    }
    on DioError catch(e) {
      print(e.message);
    }
    return model;
    }

}