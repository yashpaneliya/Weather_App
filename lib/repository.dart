import 'package:Weather_App/weathermodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class weatherRepo{
  Future<WeatherModel> getWeather(String city)async{
    final result = await http.Client().get("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=780a9a0bbb5760be76f798d4db07e6e7");
    print(result);
    print('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=780a9a0bbb5760be76f798d4db07e6e7');
    if(result.statusCode!=200)
    {
      throw Exception();
    }
    print("else part");
    return parseJSON(result.body);
  }

  WeatherModel parseJSON(final response){
    final jsondecoded=json.decode(response);
    final jsonmain=jsondecoded["main"];
    print(jsonmain);
    return WeatherModel.fromJSON(jsonmain);
  }

}