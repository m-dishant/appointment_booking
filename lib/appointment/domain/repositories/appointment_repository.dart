import '../entities/appointment.dart';
import '../entities/appointment_slot.dart';

abstract class AppointmentRepository {
  Future<List<AppointmentSlot>> getAvailableSlots(DateTime date);
  Future<List<Appointment>> getMyAppointments();
  Future<void> bookAppointment(Appointment appointment);
  Future<void> cancelAppointment(String appointmentId);
  Future<void> rescheduleAppointment(
      String appointmentId, DateTime newDate, String newTime);
}
