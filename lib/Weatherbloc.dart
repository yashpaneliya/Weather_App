import 'package:Weather_App/repository.dart';
import 'package:Weather_App/weathermodel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class WeatherEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent{
  final city;

  FetchWeather(this.city);
  @override
  List<Object> get props => [city];
}

class ResetWeather extends WeatherEvent{

}

class WeatherState extends Equatable{
  @override
  List<Object> get props => [];
}

class notsearched extends WeatherState{

}

class loading extends WeatherState{

}

class loaded extends WeatherState{
final weather;


  loaded(this.weather);
WeatherModel get getWeather => weather;

@override
  // TODO: implement props
  List<Object> get props => [weather];
}

class notloaded extends WeatherState{

}

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{
 
 weatherRepo wp;
 WeatherBloc(this.wp);

  @override
  // TODO: implement initialState
  WeatherState get initialState => notsearched();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // TODO: implement mapEventToState
    if(event is FetchWeather){
      yield loading();
      try{
        WeatherModel weather =await wp.getWeather(event.city);
        yield loaded(weather);
      }
      catch(e){
        print("hiii");
        yield notloaded();
      }
    }
    else if(event is ResetWeather){
      yield notsearched();
    }
  }

}