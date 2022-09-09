import 'package:tech_express_booking_driver/model/ticket_model.dart';

class Utils {
  static List<TicketModel>? sortTickets(List<TicketModel>? data) {
    if (data == null) return data;
    data.sort((a, b) => b.timeScanned!.compareTo(a.timeScanned!));
    return data;
  }
}
