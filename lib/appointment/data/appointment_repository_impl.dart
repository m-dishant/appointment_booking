import '../domain/entities/appointment.dart';
import '../domain/entities/appointment_slot.dart';
import '../domain/repositories/appointment_repository.dart';
import 'appointment_data_source.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentDataSource dataSource;

  AppointmentRepositoryImpl(this.dataSource);

  @override
  Future<List<AppointmentSlot>> getAvailableSlots(DateTime date) {
    return dataSource.getAvailableSlots(date);
  }

  @override
  Future<List<Appointment>> getMyAppointments() {
    return dataSource.getMyAppointments();
  }

  @override
  Future<void> bookAppointment(Appointment appointment) {
    return dataSource.bookAppointment(appointment);
  }

  @override
  Future<void> cancelAppointment(String appointmentId) {
    return dataSource.cancelAppointment(appointmentId);
  }

  @override
  Future<void> rescheduleAppointment(
      String appointmentId, DateTime newDate, String newTime) {
    return dataSource.rescheduleAppointment(appointmentId, newDate, newTime);
  }
}
