import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tech_express_booking_driver/model/ticket_model.dart';
import 'package:tech_express_booking_driver/screens/ticket_details.dart';
import 'package:tech_express_booking_driver/screens/tickets_search.dart';
import 'package:tech_express_booking_driver/service/cloud_firestore_service.dart';
import 'package:tech_express_booking_driver/utils/utils.dart';

class ScannedTicketsPage extends StatelessWidget {
  const ScannedTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<TicketModel>>(
        stream: CloudFirestoreService.instance.getAllScannedTickets(),
        builder: (context, snapshot) {
          final docs = Utils.sortTickets(
              snapshot.data?.docs.map((e) => e.data()).toList());

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: const Text('Scanned Tickets'),
              actions: [
                IconButton(
                    onPressed: () {
                      if (docs == null) return;
                      if (snapshot.hasData && docs.isNotEmpty) {
                        showSearch(
                            context: context,
                            delegate: TicketSearch(tickets: docs));
                      }
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
            body: Builder(builder: ((context) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                //TODO show a loading indicator
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.green,
                ));
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error Loading scanned tickets'),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('There are no scanned tickets'),
                  );
                }
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: ((context, index) => ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TicketDetails(
                                        ticketModel: docs![index])));
                          },
                          leading: const Icon(Icons.qr_code_scanner),
                          title: Text(docs![index].id),
                          subtitle:
                              Text(Jiffy(docs[index].timeScanned).fromNow()),
                        )));
              }
              return Container();
            })),
          );
        });
  }
}
