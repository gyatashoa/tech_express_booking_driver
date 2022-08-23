import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tech_express_booking_driver/model/status.dart';
import 'package:tech_express_booking_driver/model/ticket_model.dart';

import '../constants/colors.dart';

class TicketDetails extends StatelessWidget {
  final TicketModel ticketModel;
  const TicketDetails({Key? key, required this.ticketModel}) : super(key: key);

  void _onViewQrCode(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: QrImage(
                data: ticketModel.id,
                version: QrVersions.auto,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: veppoBlue,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 32, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Booking details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total GHS${ticketModel.price}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(26),
                margin: const EdgeInsets.fromLTRB(26, 26, 26, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            ticketModel.busType.busImage,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          ticketModel.busType.name,
                          style: const TextStyle(
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.redAccent,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'From',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily:
                                                        'Poppins-Regular',
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                ticketModel.from,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        'Poppins-Medium',
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.green,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'To',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily:
                                                        'Poppins-Regular',
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                ticketModel.to,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        'Poppins-Medium',
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE4EDF0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                'assets/pngs/updown.png',
                                color: const Color(0xFF005248),
                                height: 10,
                                width: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'TICKET STATUS: ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: TicketStatus.SCANNED.value,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal))
                        ])),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'TIME SCANNED: ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: DateTime.now().format,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal))
                        ])),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(),
                    TextButton(
                        style: TextButton.styleFrom(backgroundColor: deepGreen),
                        onPressed: () => _onViewQrCode(context),
                        child: const Text(
                          'Check Qr Code',
                          style: TextStyle(color: Colors.white),
                        )),
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Passenger',
                                  style: TextStyle(color: veppoLightGrey),
                                ),
                                Text(
                                  ticketModel.userName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Gate',
                                  style: TextStyle(color: veppoLightGrey),
                                ),
                                Text(
                                  '2H',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Seat',
                                  style: TextStyle(color: veppoLightGrey),
                                ),
                                Text(
                                  ticketModel.seatNumber.toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const Spacer(flex: 2),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    const Divider(),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          ticketModel.id.substring(0, 16),
                          style: const TextStyle(
                            fontFamily: 'Barcode',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Ticket ID: ${ticketModel.id}',
                style: const TextStyle(
                  color: veppoLightGrey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on DateTime {
  String get format {
    int _hour = TimeOfDay.fromDateTime(this).hourOfPeriod;
    String _min = TimeOfDay.fromDateTime(this).minute < 10
        ? '0${TimeOfDay.fromDateTime(this).minute}'
        : '${TimeOfDay.fromDateTime(this).minute}';
    String _am_or_pm = TimeOfDay.fromDateTime(this).period.name;
    return '$day/${month < 10 ? '0$month' : month}/$year, $_hour:$_min $_am_or_pm';
  }
}
