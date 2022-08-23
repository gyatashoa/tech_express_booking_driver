import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:tech_express_booking_driver/constants/api_url.dart';
import 'package:tech_express_booking_driver/model/status.dart';
import 'package:tech_express_booking_driver/model/ticket_model.dart';

class SmsApiService {
  late Dio _dio;

  static final SmsApiService instance = SmsApiService._();

  SmsApiService._() {
    _dio = Dio();
  }

  Future sendSmsToUser(String phoneNumber) async {
    late String res;
    if (phoneNumber.startsWith('0')) {
      res = phoneNumber.substring(1).padLeft(13, '+233');
    } else {
      res = phoneNumber;
    }
    _dio.post('$sms_api_base_url/scanned', data: {'phoneNumber': res});
  }
}
