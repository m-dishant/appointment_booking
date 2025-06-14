class Appointment {
  final String id;
  final DateTime date;
  final String time;
  final String status;
  final String name;
  final String email;
  final String phone;
  final String notes;

  Appointment({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
    required this.name,
    required this.email,
    required this.phone,
    required this.notes,
  });
}
