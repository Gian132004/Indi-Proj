import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {

  String location; // location name for UI
  String? time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {
    try {
      // make the request using the instance's url
      Response response = await get(Uri.parse('https://timeapi.io/api/time/current/zone?timeZone=$url'));
      Map data = jsonDecode(response.body);
      print('API Response: $data');

      // get properties from json
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      print('Datetime: $datetime');
      print('Offset: $offset');

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      print('Final time: $now');

      // set the time property
      time = now.toString();
      print('Time property set to: $time');
    } catch (e) {
      print('Error in getTime: $e');
    }
  }

}
