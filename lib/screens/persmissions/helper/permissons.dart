
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/tools/file_importer.dart';

class AppPermissions {

   static requestLocationPermission(BuildContext context,Permission permission) async {
    PermissionStatus status = await permission.status;

    switch (status) {
      case PermissionStatus.granted:
        showSnackBar(context, 'Permission granted', Colors.green);
      case PermissionStatus.denied:
        permission.request();
        showSnackBar(context, 'Permission denied', Colors.amber);
      case PermissionStatus.permanentlyDenied:
        showSnackBar(context, 'Permanently denied', Colors.redAccent);
      default:
        showSnackBar(context, 'Something went wrong', Colors.red);
    }
  }

  static showSnackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, textAlign: TextAlign.center),
      backgroundColor: color,
    ));
  }



  static getSomePermissions(BuildContext context,List<Permission> manyPermissions) async {

    Map<Permission, PermissionStatus> somePermissionsResults =
    await manyPermissions.request();

    for(int i = 0;i<5;i++){
      requestLocationPermission(context, manyPermissions[i]);
    }
  }
}
