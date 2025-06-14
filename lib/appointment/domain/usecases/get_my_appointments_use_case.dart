import '../repositories/appointment_repository.dart';
import '../entities/appointment.dart';

class GetMyAppointmentsUseCase {
  final AppointmentRepository repository;

  GetMyAppointmentsUseCase(this.repository);

  Future<List<Appointment>> call() {
    return repository.getMyAppointments();
  }
}
