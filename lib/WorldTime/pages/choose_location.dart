import 'package:flutter/material.dart';
import 'package:motor_engine_displacement_calculator/WorldTime/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(url: 'Asia/Manila', location: 'Manila', flag: '🇵🇭'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: '🇺🇸'),
    WorldTime(url: 'Europe/London', location: 'London', flag: '🇬🇧'),
    WorldTime(url: 'Australia/Sydney', location: 'Sydney', flag: '🇦🇺'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: '🇪🇬'),
    WorldTime(url: 'Europe/Paris', location: 'Paris', flag: '🇫🇷'),
    WorldTime(url: 'America/Sao_Paulo', location: 'São Paulo', flag: '🇧🇷'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'url': instance.url,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () async {
                  await locations[index].getTime();
                  Navigator.pop(context, {
                    'location': locations[index].location,
                    'flag': locations[index].flag,
                    'url': locations[index].url,
                    'time': locations[index].time,
                    'isDaytime': locations[index].isDaytime,
                  });
                },
                title: Text(locations[index].location),
                leading: Text(
                  locations[index].flag,
                  style: TextStyle(fontSize: 32), // Adjust size as needed
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}