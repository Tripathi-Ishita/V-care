import 'package:flutter/material.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  bool editConfirmed = false;
  List<String> appointments = [];
  late DateTime selectedDate = DateTime.now();
  late TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 0);
  late TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Image(
            image: AssetImage("assets/appoint.png"),
          )
          // Date picker
          ,Text('Select a date:'),
          ElevatedButton(

            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );

              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
            child: Text(
              selectedDate == null
                  ? 'Select Date'
                  : '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
            ),
          ),
          // Time picker
          Text('Select a time:'),
          ElevatedButton(
            onPressed: () async {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                setState(() {
                  selectedTime = pickedTime;
                });
              }
            },
            child: Text(selectedTime == null
                ? 'Select Time'
                : selectedTime.format(context)),
          ),

          // Add appointment button
          ElevatedButton(
            onPressed: () {
              if (selectedDate != null && selectedTime != null) {
                final String appointment =
                    'Date: ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}, Time: ${selectedTime
                    .format(context)}';
                setState(() {
                  appointments.add(appointment);
                });
              }
            },
            child: Text('Add Appointment'),
          ),

          // List of selected appointments
          Expanded(
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final String appointment = appointments[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete),
                    alignment: Alignment.centerLeft,
                  ),
                  secondaryBackground: Container(
                    color: Colors.blue,
                    child: Icon(Icons.edit),
                    alignment: Alignment.centerRight,
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      // Show edit dialog
                      editConfirmed = showEditDialog(index, appointment) as bool;
                      return false; // Return false to prevent automatic dismissal
                    } else if (direction == DismissDirection.startToEnd) {
                      // Show delete confirmation dialog
                      bool confirm = (await showDeleteConfirmationDialog(index)) as bool;
                      if (confirm) {
                        setState(() {
                          appointments.removeAt(index);
                        });
                      }
                      return confirm;
                    }
                    return false;
                  },
                  child: ListTile(
                    title: Text(appointment),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Future<bool?>> showDeleteConfirmationDialog(int index) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Do you want to delete this appointment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> showEditDialog(int index, String appointment) async {
    DateTime pickedDate = selectedDate;
    TimeOfDay pickedTime = selectedTime;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Appointment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: pickedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );

                  if (picked != null) {
                    pickedDate = picked;
                  }
                },
                child: Text('Edit Date'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: pickedTime,
                  );

                  if (picked != null) {
                    pickedTime = picked;
                  }
                },
                child: Text('Edit Time'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                appointments[index] =
                'Date: ${pickedDate.toLocal()}, Time: ${pickedTime.format(context)}';
                setState(() {
                  selectedDate = pickedDate;
                  selectedTime = pickedTime;
                });
                Navigator.of(context).pop(true);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    return true; // Always return true when the edit dialog is closed
  }

}