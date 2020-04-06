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
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
    final WeatherBloc bloc = BlocProvider.of<WeatherBloc>(context);
    var controller = TextEditingController();
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            child: FlareActor('assets/WorldSpin.flr',fit: BoxFit.contain,animation: "roll",),
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
                    Center(child: Text("Get Weather",style: TextStyle(fontSize: 30.0,color: Colors.black),),),
                    Container(
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
                    MaterialButton(
                            minWidth: MediaQuery.of(context).size.width-50.0,
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Text('Get Weather'),
                            onPressed: (){
                              bloc.add(FetchWeather(controller.text));   //fetching the event
                            },
                    )
                  ],
                )
              );}
            else if(state is loading)
              return Center(child : CircularProgressIndicator());
            else if(state is loaded)
              return showWeather(state.getWeather, controller.text);
            else
              return Text("Error",style: TextStyle(color: Colors.black),);
          },
        )
      ],      
    );
  }
}

class showWeather extends StatelessWidget {
  WeatherModel weather;
  final city;

  showWeather(this.weather, this.city);
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.only(right: 32, left: 32, top: 10),
          child: Column(
            children: <Widget>[
              Text('$city',style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),

              Text(weather.getTemp.round().toString()+"°C",style: TextStyle(color: Colors.black, fontSize: 50),),
              Text("Temprature",style: TextStyle(color: Colors.black, fontSize: 14),),

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

              Container(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: (){
                    BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
                  },
                  color: Colors.lightBlue,
                  child: Text("Search", style: TextStyle(color: Colors.white, fontSize: 16),),

                ),
              )
            ],
          )
      );
  }
}