import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String baseURL = 'https://independentwrestlingnetwork.com/All_Wrestling_API/';
//baseURL//

String getVideoURL = 'fetch_video.php?fetch_key=IZ15DO';

String clickTOGetAllVideo = 'Click to get All Video';
String videoGetAppPage = 'Video Get App Page';
String videoListShowPage = 'Video List Show Page';

//ErrorMSG//
String getVideoError = 'Get Video Error';
String blocVideoError = 'Having issue while getting videos!';
String internetConnectionError = 'No Internet Connection!!!';

const TextStyle mediumTxtStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0, color: Colors.black);

BaseOptions dioBaseOptions = BaseOptions(
  baseUrl: baseURL,
  headers: {"Content-Type": "application/json"},
  connectTimeout: 10000,
  receiveTimeout: 10000,
);

Future<bool> isInternetConnectivityAvailable() async {
  bool status = false;
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    status = await _checkStatus(connectivityResult);
    return status;
  }
  return status;
}

Future<bool> _checkStatus(ConnectivityResult result) async {
  bool isOnline = false;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isOnline = true;
    } else {
      isOnline = false;
    }
  } on SocketException catch (_) {
    isOnline = false;
  }
  return isOnline;
}

showSnackBarMsg(BuildContext context, String msg) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: const TextStyle(color: Colors.white),
    ),
  ));
}
