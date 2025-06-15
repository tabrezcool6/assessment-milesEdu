// // ignore_for_file: use_build_context_synchronously

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:permission_handler/permission_handler.dart';

// class Permissions {
//   /// Checks and requests storage permissions based on Android version.
//   /// Returns `true` if all required permissions are granted.
//   static Future<bool> getStoragePermission() async {
//     final DeviceInfoPlugin info = DeviceInfoPlugin();
//     final AndroidDeviceInfo androidInfo = await info.androidInfo;

//     // Get the Android version as an integer.
//     final int androidVersion = double.parse(androidInfo.version.release).truncate();
//     bool havePermission = false;

//     if (androidVersion >= 13) {
//       // Request permissions for Android 13 and above.
//       final request = await [
//         Permission.photos,
//         Permission.videos,
//         Permission.manageExternalStorage
//       ].request();

//       // Check if all requested permissions are granted.
//       havePermission = request.values.every(
//         (status) => status == PermissionStatus.granted,
//       );
//     } else {
//       // Request storage permission for Android versions below 13.
//       final status = await [Permission.storage].request();
//       havePermission = status.values.every(
//         (status) => status == PermissionStatus.granted,
//       );
//     }

//     return havePermission;
//   }
// }
