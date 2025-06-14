import '../repositories/appointment_repository.dart';

class RescheduleAppointmentUseCase {
  final AppointmentRepository repository;

  RescheduleAppointmentUseCase(this.repository);

  Future<void> call(String appointmentId, DateTime newDate, String newTime) {
    return repository.rescheduleAppointment(appointmentId, newDate, newTime);
  }
}
