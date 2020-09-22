import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time;
  String flag;  // URL to an asset flag icon
  String url;   // Location url for API
  bool isDay;   // Is it day or night

  WorldTime({ this.location, this.flag, this.url });

  // Future lets a function have a temp value and that it will be void in the
  // future after the code is executed.
  Future<void> getTime() async {

    try {
      // Requesting the API
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      //Get required props from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //  Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDay = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('Error: $e');
      time = 'Could not get data.';
    }
  }
}