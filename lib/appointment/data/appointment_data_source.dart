import 'package:appointment_booking/appointment/domain/entities/appointment.dart';
import 'package:appointment_booking/appointment/domain/entities/appointment_slot.dart';

abstract class AppointmentDataSource {
  Future<List<AppointmentSlot>> getAvailableSlots(DateTime date);
  Future<List<Appointment>> getMyAppointments();
  Future<void> bookAppointment(Appointment appointment);
  Future<void> cancelAppointment(String appointmentId);
  Future<void> rescheduleAppointment(
      String appointmentId, DateTime newDate, String newTime);
}

class MockAppointmentDataSource implements AppointmentDataSource {
  @override
  Future<List<AppointmentSlot>> getAvailableSlots(DateTime date) async {
    // Return mock slots
    return [
      AppointmentSlot(time: '9:00 AM', isAvailable: true),
      AppointmentSlot(time: '10:00 AM', isAvailable: true),
      AppointmentSlot(time: '11:00 AM', isAvailable: false),
      AppointmentSlot(time: '2:00 PM', isAvailable: true),
      AppointmentSlot(time: '3:00 PM', isAvailable: true),
      AppointmentSlot(time: '4:00 PM', isAvailable: true),
    ];
  }

  @override
  Future<List<Appointment>> getMyAppointments() async {
    return [
      Appointment(
        id: '1',
        date: DateTime(2024, 12, 14),
        time: '2:00 PM',
        status: 'Confirmed',
        name: 'John Doe',
        email: 'john@example.com',
        phone: '1234567890',
        notes: 'Bring documents',
      ),
      Appointment(
        id: '2',
        date: DateTime(2024, 12, 21),
        time: '10:00 AM',
        status: 'Upcoming',
        name: 'John Doe',
        email: 'john@example.com',
        phone: '1234567890',
        notes: '',
      ),
    ];
  }

  @override
  Future<void> bookAppointment(Appointment appointment) async {
    // Simulate booking
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Future<void> cancelAppointment(String appointmentId) async {
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Future<void> rescheduleAppointment(
      String appointmentId, DateTime newDate, String newTime) async {
    await Future.delayed(Duration(milliseconds: 500));
  }
}
