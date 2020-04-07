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
    return parseJSON(result.body);
  }

  WeatherModel parseJSON(final response){
    final jsondecoded=json.decode(response);
    final jsonmain=jsondecoded["main"];
    final jsonweatherlist=jsondecoded["weather"];
    final jsonweathermap=jsonweatherlist.asMap();
    final jsonwind=jsondecoded["wind"];
    print(jsonweathermap[0]);
    final mapwithid=jsonweathermap[0];
    var finalJson={}..addAll(jsonmain)..addAll(jsonwind);
    finalJson.addAll(mapwithid);
    print(finalJson);
    return WeatherModel.fromJSON(finalJson);
  }
}