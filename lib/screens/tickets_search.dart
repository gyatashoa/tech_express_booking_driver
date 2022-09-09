import 'package:flutter/material.dart';
import 'package:tech_express_booking_driver/model/ticket_model.dart';
import 'package:tech_express_booking_driver/screens/ticket_details.dart';

class TicketSearch extends SearchDelegate<TicketModel> {
  final List<TicketModel> tickets;
  TicketSearch({required this.tickets})
      : super(searchFieldLabel: "Enter ticket id or user's name");
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final data = tickets
        .where((element) =>
            element.id.toLowerCase().contains(query.toLowerCase()) ||
            element.userName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: ((context, index) => ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            TicketDetails(ticketModel: data[index])));
              },
              leading: const Icon(Icons.qr_code_scanner),
              title: Text(data[index].id),
              subtitle: Text(data[index].userName),
            )));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final data = tickets
        .where((element) =>
            element.id.toLowerCase().contains(query.toLowerCase()) ||
            element.userName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: ((context, index) => ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            TicketDetails(ticketModel: data[index])));
              },
              leading: const Icon(Icons.qr_code_scanner),
              title: Text(data[index].id),
              subtitle: Text(data[index].userName),
            )));
  }
}
