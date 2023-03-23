import 'package:flutter/material.dart';
import 'package:primer_proyecto/database/database_helper.dart';
import 'package:primer_proyecto/models/event_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class Eventos extends StatefulWidget {
  @override
  _EventosState createState() => _EventosState();
}

class _EventosState extends State<Eventos> with TickerProviderStateMixin {
  CalendarView _calendarView = CalendarView.month;
  Key _calendarKey = UniqueKey();

  DatabaseHelper? databaseHelper;

  List<EventModel> _eventModel = [];

  DateTime? _seletedDate;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    _recuperarEventos();
  }

  void _recuperarEventos() async {
    List<EventModel> eventModel = await databaseHelper!.getAllEventos();
    setState(() {
      _eventModel = eventModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis eventos',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          ToggleButtons(
            children: [
              Icon(Icons.calendar_month),
              Icon(Icons.list),
            ],
            isSelected: [
              _calendarView == CalendarView.month,
              _calendarView == CalendarView.schedule,
            ],
            onPressed: (index) {
              setState(() {
                if (index == 0) {
                  _calendarView = CalendarView.month;
                  _calendarKey = UniqueKey();
                } else if (index == 1) {
                  _calendarView = CalendarView.schedule;
                  _calendarKey = UniqueKey();
                }
              });
            },
          ),
        ],
      ),
      body: SfCalendar(
        key: _calendarKey,
        view: _calendarView,
        dataSource: _DataSource(_eventModel),
        onTap: (calendarTapDetails) {
          if (calendarTapDetails.targetElement ==
              CalendarElement.calendarCell) {
            setState(() {
              _seletedDate = calendarTapDetails.date;
            });
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Agregar evento',
                    style: Theme.of(context).textTheme.bodyLarge),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [],
                ),
              );
            },
          );
        },
        label: const Text('Add event'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<EventModel> eventModel) {
    appointments = eventModel.map((event) {
      return Appointment(
          startTime: event.fechaEvento!,
          endTime: event.fechaEvento!.add(Duration(hours: 1)),
          subject: event.descEvento!,
          isAllDay: false,
          color: event.completado! == 1 ? Colors.grey : Colors.blue);
    }).toList();
  }
}
