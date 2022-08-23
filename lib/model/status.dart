enum TicketStatus {
  NOT_SCANNED(value: 'NOT SCANNED'),
  SCANNED(value: 'SCANNED');

  final String value;
  const TicketStatus({required this.value});
}
