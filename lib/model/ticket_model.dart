import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_express_booking_driver/model/bus_type.dart';
import 'package:tech_express_booking_driver/model/status.dart';

class TicketModel {
  final String id;
  final String userId;
  final String userName;
  final BusType busType;
  final String arrivalDepTime;
  final DateTime date;
  final double price;
  final String to;
  final String from;
  final int seatNumber;
  final DateTime createdAt;
  final TicketStatus ticketStatus;
  final DateTime? timeScanned;
  final String phoneNumber;

  TicketModel(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.busType,
      required this.arrivalDepTime,
      required this.date,
      required this.price,
      required this.to,
      required this.from,
      required this.phoneNumber,
      required this.seatNumber,
      required this.ticketStatus,
      required this.timeScanned,
      required this.createdAt});

  TicketModel.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        userId = data['userId'],
        userName = data['userName'],
        busType = _getBusType(data['busType']),
        arrivalDepTime = data['arrivalDepTime'],
        date = (data['date'] as Timestamp).toDate(),
        timeScanned = data['timeScanned'] == null
            ? null
            : (data['timeScanned'] as Timestamp).toDate(),
        price = (data['price']),
        to = (data['to']),
        phoneNumber = (data['phoneNumber']),
        from = (data['from']),
        seatNumber = (data['seatNumber']),
        ticketStatus = _getTicketStatus(data['ticketStatus'] ?? 0),
        createdAt = (data['date'] as Timestamp).toDate();

  static BusType _getBusType(int index) => BusType.values[index];
  static TicketStatus _getTicketStatus(int index) => TicketStatus.values[index];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'userId': userId,
        'busType': busType.index,
        'arrivalDepTime': arrivalDepTime,
        'date': Timestamp.fromDate(date),
        'price': price,
        'to': to,
        'from': from,
        'phoneNumber': phoneNumber,
        'timeScanned': FieldValue.serverTimestamp(),
        'ticketStatus': ticketStatus,
        'seatNumber': seatNumber,
        'createdAt': FieldValue.serverTimestamp()
      };
}
