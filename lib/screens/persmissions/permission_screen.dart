import 'package:flutter/material.dart';
import 'package:meal_mate/screens/persmissions/helper/permissons.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionExampleScreen extends StatefulWidget {
  const PermissionExampleScreen({super.key});

  @override
  State<PermissionExampleScreen> createState() =>
      _PermissionExampleScreenState();
}

class _PermissionExampleScreenState extends State<PermissionExampleScreen> {
  List<Permission> permissions = [
    Permission.camera,
    Permission.location,
    Permission.audio,
    Permission.bluetoothConnect,
    Permission.bluetoothScan,
    Permission.accessMediaLocation,
    Permission.assistant,
    Permission.sms,
    Permission.speech,
    Permission.microphone,
    Permission.calendarFullAccess,
    Permission.contacts,
    Permission.mediaLibrary,
  ];

  List<Permission> manyPermissions = [
    Permission.reminders,
    Permission.photosAddOnly,
    Permission.storage,
    Permission.videos,
    Permission.criticalAlerts,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          ElevatedButton(onPressed: () {
            AppPermissions.getSomePermissions(context,manyPermissions);
          }, child: Text("Many Permission")),
          SizedBox(
              height: 700,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: 13,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {
                        AppPermissions.requestLocationPermission(
                            context, permissions[index]);
                      },
                      child: Text(
                        "${permissions[index]}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
