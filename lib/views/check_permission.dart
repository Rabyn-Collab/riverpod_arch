import 'package:flutter/material.dart';
import 'package:flutterspod/views/map_show.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


class CheckPermission extends StatelessWidget {

  Position? position;
  LocationPermission? permission;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: () async{
             permission = await Geolocator.requestPermission();
            if(permission == LocationPermission.denied){
              permission = await Geolocator.requestPermission();
            }else if(permission == LocationPermission.deniedForever){
              await Geolocator.openAppSettings();
            }else if(permission == LocationPermission.whileInUse || permission == LocationPermission.always){
              position = await Geolocator.getCurrentPosition();
            if(position != null) Get.to(() => MapSample(position: position!));
            }
            }, child: Text('Check Permission'))
        )
    );
  }
}
