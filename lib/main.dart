import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main()=>runApp(
  MaterialApp(
    title:"Weather",
    home:Home(),
  )
);

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _HomeState();
  }
}

class _HomeState extends State<Home>{
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;

  Future getWeather() async {
    final url=Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Bangalore&units=metric&appid=be6c08281941a518a7763a15c4d2a206");
    final response=await http.get(url);
    var results=jsonDecode(response.body);
    setState((){
      this.temp=results['main']['temp'];
      this.description=results['weather'][0]['description'];
      this.currently=results['weather'][0]['main'];
      this.humidity=results['main']['humidity'];
      this.windspeed=results['wind']['speed'];
    }

    );
  }
  @override
  void initState(){
    super.initState();
    this.getWeather();
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.amber,
        title: Text("Weather",style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body:Column(
        children:<Widget>[
          Container(
            child:Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPmuD1nxu1dL1SUFlZ8zBc1GFVrZLf3JDYcQ&usqp=CAU',),
            alignment: Alignment.topCenter,

          ),

          Container(
            height:MediaQuery.of(context).size.height/3.5,
            width:MediaQuery.of(context).size.width,
            color:Colors.blue,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                Padding(
                  padding:EdgeInsets.only(bottom:10.0),
                  child:Text(
                    "Bangalore",
                    style:TextStyle(
                      color:Colors.white,
                      fontSize:30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp!=null?temp.toString()+"\u00B0 C":"Loading",
                  style:TextStyle(
                    color:Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding:EdgeInsets.only(bottom:10.0),
                  child:Text(
                    currently!=null?currently.toString():"Loading",
                    style:TextStyle(
                      color:Colors.white,
                      fontSize:25.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:Padding(
              padding:EdgeInsets.all(20.0),
              child:ListView(
                children:<Widget>[
                  ListTile(
                    leading:FaIcon(FontAwesomeIcons.temperatureHalf),
                    title:Text("Temperature",style:TextStyle(fontSize:25.0)),
                    trailing:Text(temp!=null?temp.toString()+"\u00B0 C":"Loading",style:TextStyle(fontSize:25.0)),
                  ),

                  ListTile(
                    leading:FaIcon(FontAwesomeIcons.cloud),
                    title:Text("Weather",style:TextStyle(fontSize:25.0)),
                    trailing:Text(description!=null?description.toString():"Loading",style:TextStyle(fontSize:25.0)),
                  ),

                  ListTile(
                    leading:FaIcon(FontAwesomeIcons.sun),
                    title:Text("Humidity",style:TextStyle(fontSize:25.0)),
                    trailing:Text(humidity!=null?humidity.toString()+"%":"Loading",style:TextStyle(fontSize:25.0)),
                  ),

                  ListTile(
                    leading:FaIcon(FontAwesomeIcons.wind),
                    title:Text("Wind Speed",style:TextStyle(fontSize:25.0)),
                    trailing:Text(windspeed!=null?windspeed.toString()+"%":"Loading",style:TextStyle(fontSize:25.0)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}