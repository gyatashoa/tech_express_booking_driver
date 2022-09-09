import 'package:flutter/material.dart';
import 'package:tech_express_booking_driver/screens/scanned_tickets.dart';
import 'package:tech_express_booking_driver/screens/scanning_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Ticket Scanner'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          _CustomCard(
            icon: Icons.qr_code_scanner_outlined,
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ScanningPage()));
            },
            title: 'Scan a ticket',
          ),
          _CustomCard(
            icon: Icons.document_scanner,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const ScannedTicketsPage()));
            },
            title: 'Check Scanned tickets',
          ),
        ],
      ),
    );
  }
}

class _CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;
  const _CustomCard(
      {super.key,
      required this.icon,
      this.color = Colors.green,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: devSize.height * 0.2,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(const Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
