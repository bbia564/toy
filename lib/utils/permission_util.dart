import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static Future<bool> checkPermission(List<Permission> permissionList) async {
    List<Permission> newPermissionList = [];

    for (Permission permission in permissionList) {
      PermissionStatus status = await permission.status;

      if (!status.isGranted || !status.isLimited) {
        newPermissionList.add(permission);
      }
    }

    if (newPermissionList.isNotEmpty) {
      if (Platform.isAndroid) {
        _showTopInstructionsDialog(newPermissionList);
      }
      PermissionStatus permissionStatus =
          await _requestPermission(newPermissionList);
      switch (permissionStatus) {
        case PermissionStatus.denied:
          _showFailedDialog(newPermissionList, isPermanentlyDenied: true);
          return false;

        case PermissionStatus.granted:
        case PermissionStatus.limited:
        case PermissionStatus.provisional:
          BotToast.cleanAll();
          return true;

        case PermissionStatus.restricted:
        case PermissionStatus.permanentlyDenied:
          _showFailedDialog(newPermissionList, isPermanentlyDenied: true);
          break;
      }
    } else {
      return true;
    }
    return false;
  }

  static Future<PermissionStatus> _requestPermission(
      List<Permission> permissionList) async {
    Map<Permission, PermissionStatus> statuses = await permissionList.request();
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;
    statuses.forEach((key, value) {
      if (!value.isGranted || !value.isLimited) {
        currentPermissionStatus = value;
        return;
      }
    });
    return currentPermissionStatus;
  }

  static Future<bool> checkLocationAlways() async {
    PermissionStatus status = PermissionStatus.granted;
    status = await _checkSinglePermission(Permission.locationWhenInUse);

    PermissionStatus status2 = PermissionStatus.denied;

    if (status.isGranted) {
      status2 = await _checkSinglePermission(Permission.locationAlways);
    }

    if (status.isGranted && status2.isGranted) {
      return true;
    } else if (status.isDenied || status2.isDenied) {
      _showFailedDialog(
          [Permission.locationWhenInUse, Permission.locationAlways]);
    } else {
      _showFailedDialog(
        [Permission.locationWhenInUse, Permission.locationAlways],
        isPermanentlyDenied: true,
      );
    }
    return false;
  }

  static _checkSinglePermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;

    if (!status.isGranted) {
      currentPermissionStatus = await _requestPermission([permission]);
    }

    return currentPermissionStatus;
  }

  static Future<Permission> getMediumPermission({bool isVideo = false}) async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      int sdkVersion = androidInfo.version.sdkInt;
      if (sdkVersion >= 33) {
        return isVideo ? Permission.videos : Permission.photos;
      } else {
        return Permission.storage;
      }
    } else {
      return Permission.photos;
    }
  }

  static _showFailedDialog(List<Permission> permissionList,
      {bool isPermanentlyDenied = false}) async {
    BotToast.cleanAll();
    String instructions = await _getInstructions(permissionList);
    BotToast.showText(text: instructions);
  }

  static Future<String> _getInstructions(
      List<Permission> permissionList) async {
    late Permission failedPermission;

    for (Permission permission in permissionList) {
      PermissionStatus status = await permission.status;

      if (!status.isGranted || !status.isLimited) {
        failedPermission = permission;
        break;
      }
    }
    String instructions = '';
    if (failedPermission == Permission.camera) {
      instructions =
          'You need to turn on camera permissions to take photos and record video content for you.';
    }
    if (failedPermission == Permission.storage) {
      instructions =
          'You need to enable storage permissions to save your selected photos, videos, and more.';
    }
    if (failedPermission == Permission.photos) {
      instructions =
          'You need to enable photo access to provide you with the ability to publish or save the photo content of your choice';
    }
    if (failedPermission == Permission.videos) {
      instructions =
          'You are required to enable video access in order to provide you with the ability to publish or save the video content of your choice。';
    }
    return instructions;
  }

  static _showTopInstructionsDialog(List<Permission> permissionList) async {
    String instructions = await _getInstructions(permissionList);
    BotToast.showCustomNotification(
      dismissDirections: [DismissDirection.up],
      duration: const Duration(hours: 24),
      toastBuilder: (cancel) {
        return IntrinsicHeight(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Permission instruction',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  instructions,
                  style: const TextStyle(
                    color: Color(0xFF727272),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
