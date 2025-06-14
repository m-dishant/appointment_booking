import 'package:flutter/material.dart';
import '../domain/entities/appointment.dart';
import '../domain/entities/appointment_slot.dart';
import '../domain/usecases/get_available_slots_use_case.dart';
import '../domain/usecases/get_my_appointments_use_case.dart';
import '../domain/usecases/book_appointment_use_case.dart';
import '../domain/usecases/cancel_appointment_use_case.dart';
import '../domain/usecases/reschedule_appointment_use_case.dart';

class AppointmentViewModel extends ChangeNotifier {
  final GetAvailableSlotsUseCase getAvailableSlotsUseCase;
  final GetMyAppointmentsUseCase getMyAppointmentsUseCase;
  final BookAppointmentUseCase bookAppointmentUseCase;
  final CancelAppointmentUseCase cancelAppointmentUseCase;
  final RescheduleAppointmentUseCase rescheduleAppointmentUseCase;

  List<AppointmentSlot> availableSlots = [];
  List<Appointment> myAppointments = [];
  bool isLoading = false;
  String? error;

  AppointmentViewModel({
    required this.getAvailableSlotsUseCase,
    required this.getMyAppointmentsUseCase,
    required this.bookAppointmentUseCase,
    required this.cancelAppointmentUseCase,
    required this.rescheduleAppointmentUseCase,
  });

  Future<void> fetchAvailableSlots(DateTime date) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      availableSlots = await getAvailableSlotsUseCase(date);
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMyAppointments() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      myAppointments = await getMyAppointmentsUseCase();
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> bookAppointment(Appointment appointment) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await bookAppointmentUseCase(appointment);
      await fetchMyAppointments();
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> cancelAppointment(String appointmentId) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await cancelAppointmentUseCase(appointmentId);
      await fetchMyAppointments();
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> rescheduleAppointment(
      String appointmentId, DateTime newDate, String newTime) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await rescheduleAppointmentUseCase(appointmentId, newDate, newTime);
      await fetchMyAppointments();
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
