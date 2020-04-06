import 'package:Weather_App/weathermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class weatherRepo{
  Future<WeatherModel> getWeather(String city)async{
    final result=await http.Client().get("https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2");
    if(result.statusCode!=200)
    {
      throw Exception();
    }
    else{
      return parseJSON(result);
    }
  }

  WeatherModel parseJSON(final response){
    final jsondecoded=json.decode(response);
    final jsonmain=jsondecoded("main");
    return WeatherModel.fromJSON(jsonmain);
  }
}