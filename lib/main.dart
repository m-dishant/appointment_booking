import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appointment/presentation/appointment_screen.dart';
import 'appointment/presentation/appointment_view_model.dart';
import 'appointment/data/appointment_data_source.dart';
import 'appointment/data/appointment_repository_impl.dart';
import 'appointment/domain/usecases/get_available_slots_use_case.dart';
import 'appointment/domain/usecases/get_my_appointments_use_case.dart';
import 'appointment/domain/usecases/book_appointment_use_case.dart';
import 'appointment/domain/usecases/cancel_appointment_use_case.dart';
import 'appointment/domain/usecases/reschedule_appointment_use_case.dart';

void main() {
  final dataSource = MockAppointmentDataSource();
  final repository = AppointmentRepositoryImpl(dataSource);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppointmentViewModel(
            getAvailableSlotsUseCase: GetAvailableSlotsUseCase(repository),
            getMyAppointmentsUseCase: GetMyAppointmentsUseCase(repository),
            bookAppointmentUseCase: BookAppointmentUseCase(repository),
            cancelAppointmentUseCase: CancelAppointmentUseCase(repository),
            rescheduleAppointmentUseCase:
                RescheduleAppointmentUseCase(repository),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: const AppointmentScreen(),
    );
  }
}
