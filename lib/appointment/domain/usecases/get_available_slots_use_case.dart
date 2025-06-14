import '../repositories/appointment_repository.dart';
import '../entities/appointment_slot.dart';

class GetAvailableSlotsUseCase {
  final AppointmentRepository repository;

  GetAvailableSlotsUseCase(this.repository);

  Future<List<AppointmentSlot>> call(DateTime date) {
    return repository.getAvailableSlots(date);
  }
}
