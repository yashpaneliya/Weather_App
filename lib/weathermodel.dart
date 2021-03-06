class WeatherModel{
  final temp;
  final pressure;
  final humidity;
  final max_temp;
  final min_temp;
  final desc;
  final speed;
  final iconid;
  WeatherModel(this.temp, this.pressure, this.humidity, this.max_temp, this.min_temp,this.speed,this.desc,this.iconid);

  double get getTemp => temp-273.01;
  double get getMaxTemp => max_temp-273.01;
  double get getMinTemp => min_temp-273.01;
  int get getpre => pressure;
  int get gethumid => humidity;
  String get getDesc => desc;
  double get getSpeed => speed;
  String get icon => iconid;

  factory WeatherModel.fromJSON(Map<dynamic,dynamic> json){
    return WeatherModel(
      json["temp"],
      json["pressure"],
      json["humidity"],
      json["temp_max"],
      json["temp_min"],
      json["speed"],
      json["description"],
      json["icon"]
    );
  }
}