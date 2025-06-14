import '../repositories/appointment_repository.dart';

class CancelAppointmentUseCase {
  final AppointmentRepository repository;

  CancelAppointmentUseCase(this.repository);

  Future<void> call(String appointmentId) {
    return repository.cancelAppointment(appointmentId);
  }
}
