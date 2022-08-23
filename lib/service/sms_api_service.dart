import 'package:dio/dio.dart';
import 'package:tech_express_booking_driver/constants/api_url.dart';

class SmsApiService {
  late Dio _dio;

  static final SmsApiService instance = SmsApiService._();

  SmsApiService._() {
    _dio = Dio();
  }

  Future sendSmsToUser(
      {required String phoneNumber,
      required String name,
      required String ticketId}) async {
    late String res;
    if (phoneNumber.startsWith('0')) {
      res = phoneNumber.substring(1).padLeft(13, '+233');
    } else {
      res = phoneNumber;
    }
    try {
      _dio.post('$sms_api_base_url/scanned',
          data: {'phoneNumber': res, 'name': name, 'ticketId': ticketId});
    } on Exception {}
  }
}
