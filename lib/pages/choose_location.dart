import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:world_clock/services/world_time.dart';
import 'package:world_clock/services/locations.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List locations;

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    //  Navigate to Home
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time':instance.time,
      'isDay': instance.isDay
    });
  }

  void updateLocations() async{
    locations = [for(var loc in locs) WorldTime(url: loc, location: getLocationName(loc), flag: 'world.png')];
  }

  String getLocationName(str) {
    var index = str.lastIndexOf('/');
    var result = str.substring(index + 1);
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateLocations();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations != null? locations.length : 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
