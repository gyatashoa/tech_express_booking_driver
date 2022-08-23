import 'package:flutter_test/flutter_test.dart';
import 'package:tech_express_booking_driver/service/sms_api_service.dart';

void main() {
  test('test sms api service', () async {
    var res = await SmsApiService.instance.sendSmsToUser(
        phoneNumber: '0504826799',
        name: 'Asamoah Yeboah Felix',
        ticketId: 'sdsdf',
        test: true);
    expect(null, res);
  });
}
