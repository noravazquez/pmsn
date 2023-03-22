import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Eventos extends StatefulWidget {
  @override
  _EventosState createState() => _EventosState();
}

class _EventosState extends State<Eventos> with TickerProviderStateMixin {
  CalendarView _calendarView = CalendarView.month;
  Key _calendarKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syncfusion Calendar'),
        actions: [
          PopupMenuButton<CalendarView>(
            onSelected: (view) {
              setState(() {
                _calendarView = view;
                _calendarKey =
                    UniqueKey(); // Cambia la clave para reconstruir el calendario
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: CalendarView.month,
                child: Text(
                  'Month',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              PopupMenuItem(
                value: CalendarView.schedule,
                child: Text(
                  'Schedule',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
            icon: _calendarView == CalendarView.month
                ? Icon(Icons.list)
                : Icon(Icons.calendar_month),
          ),
        ],
      ),
      body: SfCalendar(
        key: _calendarKey, // Agrega la clave a la instancia de SfCalendar
        view: _calendarView,
        dataSource: getCalendarDataSource(),
        // Resto de las propiedades de la vista del calendario
      ),
    );
  }

  _DataSource getCalendarDataSource() {
    final List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Meeting',
      color: Colors.pink,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 4)),
      endTime: DateTime.now().add(const Duration(hours: 5)),
      subject: 'Release Meeting',
      color: Colors.lightBlueAccent,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 6)),
      endTime: DateTime.now().add(const Duration(hours: 7)),
      subject: 'Performance check',
      color: Colors.amber,
    ));

    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}
/*import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Eventos extends StatefulWidget {
  @override
  _EventosState createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  CalendarView _calendarView = CalendarView.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Screen'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _calendarView == CalendarView.month
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          _calendarView = CalendarView.schedule;
                        });
                      },
                      child: Text('Schedule'),
                    )
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          _calendarView = CalendarView.month;
                        });
                      },
                      child: Text('Month'),
                    ),
            ],
          ),
          Expanded(
            child: SfCalendar(
              view: _calendarView,
              dataSource: getCalendarDataSource(),
            ),
          ),
        ],
      ),
    );
  }

  _DataSource getCalendarDataSource() {
    final List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Meeting',
      color: Colors.pink,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 4)),
      endTime: DateTime.now().add(const Duration(hours: 5)),
      subject: 'Release Meeting',
      color: Colors.lightBlueAccent,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 6)),
      endTime: DateTime.now().add(const Duration(hours: 7)),
      subject: 'Performance check',
      color: Colors.amber,
    ));

    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}*/
/*import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Eventos extends StatefulWidget {
  @override
  _EventosState createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  final CalendarController _calendarController = CalendarController();
  CalendarView _currentView = CalendarView.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SfCalendar(
              view: _currentView,
              allowedViews: [CalendarView.month, CalendarView.schedule],
              dataSource: getCalendarDataSource(),
              controller: _calendarController,
            ),
          ),
        ],
      ),
    );
  }

  _DataSource getCalendarDataSource() {
    final List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Meeting',
      color: Colors.pink,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 4)),
      endTime: DateTime.now().add(const Duration(hours: 5)),
      subject: 'Release Meeting',
      color: Colors.lightBlueAccent,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 6)),
      endTime: DateTime.now().add(const Duration(hours: 7)),
      subject: 'Performance check',
      color: Colors.amber,
    ));

    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}*/
