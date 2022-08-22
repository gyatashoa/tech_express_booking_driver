import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_express_booking_driver/model/status.dart';
import 'package:tech_express_booking_driver/model/ticket_model.dart';

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
      await _firestore
          .collection(ticketsCollection)
          .doc(id)
          .update({'ticketStatus': TicketStatus.SCANNED.index});
    } on Exception {
      return 'Error connecting to database';
    }
  }
}
