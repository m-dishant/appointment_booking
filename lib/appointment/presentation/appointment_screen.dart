import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/entities/appointment.dart';
import '../domain/entities/appointment_slot.dart';
import 'appointment_view_model.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime selectedDate = DateTime(2024, 12, 14);
  String? selectedTime;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final vm = Provider.of<AppointmentViewModel>(context, listen: false);
    vm.fetchAvailableSlots(selectedDate);
    vm.fetchMyAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('BookMe'),
            backgroundColor: Colors.white,
            elevation: 1,
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
          body: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Center(
                        child: Column(
                          children: const [
                            Text(
                              'Book Your Appointment',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Select your preferred date and time slot',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildCalendar(vm),
                      const SizedBox(height: 24),
                      _buildTimeSlots(vm),
                      const SizedBox(height: 24),
                      _buildBookingForm(vm),
                      const SizedBox(height: 24),
                      _buildMyAppointments(vm),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _buildCalendar(AppointmentViewModel vm) {
    // For simplicity, show a horizontal list of days for December 2024
    final days = List.generate(31, (i) => DateTime(2024, 12, i + 1));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {},
            ),
            const Text('December 2024',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('S'),
            Text('M'),
            Text('T'),
            Text('W'),
            Text('T'),
            Text('F'),
            Text('S'),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final day = days[i];
              final isSelected = selectedDate.day == day.day;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = day;
                    selectedTime = null;
                  });
                  vm.fetchAvailableSlots(day);
                },
                child: Container(
                  width: 40,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlots(AppointmentViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Available Times',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(
          'December ${selectedDate.day}, 2024',
          style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: vm.availableSlots.map((slot) {
            final isSelected = selectedTime == slot.time;
            return ChoiceChip(
              label: Text(slot.time),
              selected: isSelected,
              onSelected: slot.isAvailable
                  ? (selected) {
                      setState(() {
                        selectedTime = slot.time;
                      });
                    }
                  : null,
              selectedColor: Colors.blue,
              backgroundColor:
                  slot.isAvailable ? Colors.white : Colors.grey[300],
              labelStyle: TextStyle(
                color: slot.isAvailable
                    ? (isSelected ? Colors.white : Colors.blue)
                    : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBookingForm(AppointmentViewModel vm) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Book Appointment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email Address'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter your email' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter your phone' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                decoration:
                    const InputDecoration(labelText: 'Notes (Optional)'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedTime == null
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            final appointment = Appointment(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              date: selectedDate,
                              time: selectedTime!,
                              status: 'Confirmed',
                              name: _nameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              notes: _notesController.text,
                            );
                            vm.bookAppointment(appointment);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Confirm Booking',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyAppointments(AppointmentViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('My Appointments',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            TextButton(
              onPressed: () {},
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...vm.myAppointments.map((a) => Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: Icon(
                  a.status == 'Confirmed'
                      ? Icons.check_circle
                      : Icons.access_time,
                  color: a.status == 'Confirmed' ? Colors.green : Colors.blue,
                ),
                title: Text(
                    '${a.date.month}/${a.date.day}/${a.date.year} • ${a.time}'),
                subtitle: Text(a.status),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Reschedule logic (show dialog, etc.)
                      },
                      child: const Text('Reschedule'),
                    ),
                    TextButton(
                      onPressed: () {
                        vm.cancelAppointment(a.id);
                      },
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
