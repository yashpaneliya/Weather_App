class WeatherModel{
  final temp;
  final pressure;
  final humidity;
  final max_temp;
  final min_temp;

  WeatherModel(this.temp, this.pressure, this.humidity, this.max_temp, this.min_temp);

  double get getTemp => temp-272.5;
  double get getMaxTemp => max_temp-272.5;
  double get getMinTemp => min_temp-272.5;

  factory WeatherModel.fromJSON(Map<String,dynamic> json){
    return WeatherModel(
      json["temp"],
      json["pressure"],
      json["humidity"],
      json["temp_max"],
      json["temp_min"]
    );
  }
}