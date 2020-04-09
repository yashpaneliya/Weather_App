import 'package:Weather_App/Weatherbloc.dart';
import 'package:Weather_App/repository.dart';
import 'package:Weather_App/weathermodel.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()
{
  runApp(
    MaterialApp(
    theme: ThemeData(
      fontFamily: 'gs',
      backgroundColor: Colors.blue
    ),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: BlocProvider(
        create: (context) => WeatherBloc(weatherRepo()),
        child: SearchPage(),
      ),
    ),
  ));
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WeatherBloc>(context);
    var controller = TextEditingController();
    return ListView(
      children: <Widget>[
        Center(
          child: Container(
            child: FlareActor('assets/WorldSpin.flr',fit: BoxFit.contain,animation: "roll"),
            height: 300.0,
            width: 300.0,
          ),
        ),

        BlocBuilder<WeatherBloc,WeatherState>(
          builder: (context,state){
            if(state is notsearched)
              {return Container(
                child:Column(
                  children: <Widget>[
                    Center(child: Container(margin:EdgeInsets.only(top:20.0),child: Text("Weather-Wise",style: TextStyle(fontSize: 30.0,color: Colors.black),)),),
                    Container(
                      margin: EdgeInsets.only(top: 25.0),
                      width: MediaQuery.of(context).size.width-50.0,
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.black,),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Colors.blue,
                                  style: BorderStyle.solid
                              )
                          ),
                          hintText: "Search city",
                          hintStyle: TextStyle(color: Colors.black),
                        ),
                        style: TextStyle(color: Colors.black),

                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:30.0),
                      height: 50.0,
                      child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width-50.0,
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: Text('Get Weather',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                              onPressed: (){
                                bloc.add(FetchWeather(controller.text));   //fetching the event
                              },
                      ),
                    )
                  ],
                )
              );}
            else if(state is loading)
              return Center(child : CircularProgressIndicator());
            else if(state is loaded)
              return showWeather(state.getWeather, controller.text);
            else
              return Center(
                child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 40.0,bottom: 25.0),
                    width: MediaQuery.of(context).size.width-270.0,
                    child: Image.asset('assets/nodata.png',fit: BoxFit.cover,)),
                  Text('Oops!!! No Weather data found...',style: TextStyle(color: Colors.grey,fontSize: 25.0),),
                  Container(
                margin: EdgeInsets.only(top:40.0),
                width: MediaQuery.of(context).size.width-80.0,
                height: 50,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: (){
                    BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
                  },
                  color: Colors.lightBlue,
                  child: Text("Back", style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              )
                ],),
              );
          },
        )
      ],      
    );
  }
}

class showWeather extends StatelessWidget {
  final WeatherModel weather;
  final city;

  showWeather(this.weather, this.city);
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.only(right: 32, left: 32, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.location_city),
                    Text('$city',style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(width:70.0,height:70.0,child: Image.network('http://openweathermap.org/img/w/${weather.icon.toString()}.png',fit: BoxFit.cover)),
                  Column(children: <Widget>[
                    Text(weather.getTemp.round().toString()+"°C",style: TextStyle(color: Colors.black, fontSize: 50),),
              Text("Temprature",style: TextStyle(color: Colors.black, fontSize: 14),),
                  ],)
                ],
              ),
              

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(weather.getMinTemp.round().toString()+"°C",style: TextStyle(color: Colors.black, fontSize: 30),),
                      Text("Min Temprature",style: TextStyle(color: Colors.black, fontSize: 14),),
                    ],
                  ),

                  Column(
                    children: <Widget>[
                      Text(weather.getMaxTemp.round().toString()+"°C",style: TextStyle(color: Colors.black, fontSize: 30),),
                      Text("Max Temprature",style: TextStyle(color: Colors.black, fontSize: 14),),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Text(weather.getpre.round().toString()+" hpa",style: TextStyle(color: Colors.black, fontSize: 30),),
              Text("Pressure",style: TextStyle(color: Colors.black, fontSize: 14),),
              SizedBox(
                height: 20,
              ),
              
              Text(weather.gethumid.round().toString()+" %",style: TextStyle(color: Colors.black, fontSize: 30),),
              Text("Humidity",style: TextStyle(color: Colors.black, fontSize: 14),),
              SizedBox(
                height: 20,
              ),

              Text(weather.getSpeed.toString()+" m/s",style: TextStyle(color: Colors.black, fontSize: 30),),
              Text("Wind Speed",style: TextStyle(color: Colors.black, fontSize: 14),),
              SizedBox(
                height: 20,
              ),

              Text(weather.getDesc.toUpperCase()+" ",style: TextStyle(color: Colors.black, fontSize: 30),),
              Text("Description",style: TextStyle(color: Colors.black, fontSize: 14),),
              SizedBox(
                height: 20,
              ),
              
              Container(
                margin: EdgeInsets.all(10.0),
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: (){
                    BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
                  },
                  color: Colors.lightBlue,
                  child: Text("Back", style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              )
            ],
          )
      );
  }
}