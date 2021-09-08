import 'package:http/http.dart' as http;
import '../models/models.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:device_info/device_info.dart';

abstract class AuthRepo {
  Future<Account> signIn(String email, String password);
  Future<void> signOut();
}

class AuthService extends AuthRepo {

  final baseUrl = Uri.parse("https://bm-asf-test-api.vtech.com/api/v1/account/signin");

  @override
  Future<Account> signIn(String email, String password) async {

    dynamic deviceId;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }

    print('testing');

    final http.Response response = await http.post(
      baseUrl,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "x-mobile-notification-id": deviceId,
        "x-mobile-os": 'IOS',
        "x-merchant-id": 'VTBM01',
        "x-request-timestamp": '1630915159920',
      },
      body: jsonEncode(<String, String> {
        "token": "HPk1Hx",
        "email": "liamtester9@gmail.com",
        "password": "3ed4RF5tg\$",
        "name": "Liam",
        "consent_pp": "true",
        "consent_tu": "true",
        "language": "en",
        "country": "US"
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body) as Map;
      return Account(guid: decoded['account_guid'], status: decoded['account_status'], needVerify: decoded['verification_email_require']);
    } else {
      throw Exception('Error from Exception');
    }
  }

  Future<Account> verify(String code) async {

    dynamic deviceId;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }

    final http.Response response = await http.post(
      Uri.parse("https://bm-asf-test-api.vtech.com/api/v1/account/verify/account-signin"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "x-mobile-notification-id": deviceId,
        "x-mobile-os": 'IOS',
        "x-merchant-id": 'VTBM01',
        "x-request-timestamp": '1630915159920',
      },
      body: jsonEncode(<String, String> {
        "verification_code": code
      }),
    );

    print(code);
    print(response.body);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body) as Map;
      print(decoded);
      return Account(guid: decoded['account_guid'], status: decoded['account_status'], needVerify: decoded['verification_email_require']);
    } else {
      throw Exception('Error from Exception');
    }
  }

  @override
  Future<void> signOut() async {
    return null;
  }
}