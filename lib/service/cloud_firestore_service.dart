import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_express_booking_driver/model/status.dart';
import 'package:tech_express_booking_driver/model/ticket_model.dart';
import 'package:tech_express_booking_driver/service/sms_api_service.dart';

class CloudFirestoreService {
  late FirebaseFirestore _firestore;

  static final CloudFirestoreService instance = CloudFirestoreService._();

  CloudFirestoreService._() {
    _firestore = FirebaseFirestore.instance;
  }

  final ticketsCollection = 'Tickets';

  Future getTicketDetails(String id) async {
    try {
      var res = await _firestore
          .collection(ticketsCollection)
          .doc(id)
          .withConverter<TicketModel>(
              fromFirestore: (data, _) => TicketModel.fromJson(data.data()!),
              toFirestore: (value, _) => value.toJson())
          .get();
      if (!res.exists) {
        return 'No ticket with found with the specified qr code';
      }
      return res.data();
    } on Exception {
      return 'Error connecting to database';
    }
  }

  Future updateScanningStatus(String id) async {
    try {
      var res = await getTicketDetails(id);
      if (res is String) {
        return res;
      }
      var data = res as TicketModel;
      if (data.ticketStatus == TicketStatus.SCANNED) {
        return 'Ticket has already been scanned';
      }
      await _firestore.collection(ticketsCollection).doc(id).update({
        'ticketStatus': TicketStatus.SCANNED.index,
        'timeScanned': FieldValue.serverTimestamp()
      });
      SmsApiService.instance.sendSmsToUser(
          phoneNumber: data.phoneNumber,
          name: data.userName,
          ticketId: data.id);
      return data;
    } on Exception {
      return 'Error connecting to database';
    }
  }

  Stream<QuerySnapshot<TicketModel>> getAllScannedTickets() async* {
    yield* _firestore
        .collection(ticketsCollection)
        .where('ticketStatus', isEqualTo: TicketStatus.SCANNED.index)
        // .orderBy('timeScanned', descending: true)
        .withConverter<TicketModel>(
            fromFirestore: (data, _) => TicketModel.fromJson(data.data()!),
            toFirestore: (value, _) => value.toJson())
        .snapshots();
  }
}
