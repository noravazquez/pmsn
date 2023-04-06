import 'package:flutter/material.dart';
import 'package:primer_proyecto/database/database_helper.dart';
import 'package:primer_proyecto/models/event_model.dart';
import 'package:primer_proyecto/provider/flags_provider.dart';
import 'package:provider/provider.dart';
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

  DateTime? _selectedDate;

  TextEditingController _controller = TextEditingController();

  int? _selectedEventId;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    _recuperarEventos();
    _selectedDate = DateTime.now();
  }

  void _recuperarEventos() async {
    List<EventModel> eventModel = await databaseHelper!.getAllEventos();
    setState(() {
      _eventModel = eventModel;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis eventos'.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
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
        onTap: (calendarTapDetails) async {
          if (calendarTapDetails.targetElement ==
              CalendarElement.calendarCell) {
            List<MyAppointment> appointment =
                (calendarTapDetails.appointments as List<dynamic>)
                    .whereType<MyAppointment>()
                    .toList();
            if (appointment.isNotEmpty) {
              if (appointment.length == 1) {
                _showDetailsEvent(appointment.first, flag);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Seleccione un evento',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      content: Container(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: appointment.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(appointment[index].subject,
                                  style: Theme.of(context).textTheme.bodyLarge),
                              onTap: () {
                                Navigator.pop(context);
                                _showDetailsEvent(appointment[index], flag);
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            }
            setState(() {
              _selectedDate = calendarTapDetails.date;
            });
          } else if (calendarTapDetails.targetElement ==
              CalendarElement.appointment) {
            MyAppointment appointment =
                calendarTapDetails.appointments![0] as MyAppointment;
            _showDetailsEvent(appointment, flag);
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showDialog(context, flag);
        },
        label: Text('Add event', style: Theme.of(context).textTheme.bodyMedium),
        icon: Icon(Icons.add, color: Theme.of(context).iconTheme.color),
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context, FlagsProvider flag) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                'Crear Evento',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              content: Text(
                '¿Deseas crear un evento para la fecha ${DateFormat.yMMMMd().format(_selectedDate!)}?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showAddEventDialog(context, flag);
                    },
                    child: Text(
                      'Aceptar',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancelar',
                        style: Theme.of(context).textTheme.bodyMedium)),
              ],
            );
          },
        );
      },
    );
  }

  Future<dynamic> _showAddEventDialog(
      BuildContext context, FlagsProvider flag) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar evento',
              style: Theme.of(context).textTheme.titleLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Fecha para el evento: ${DateFormat.yMMMMd().format(_selectedDate!)}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyLarge,
                decoration:
                    InputDecoration(labelText: 'Descripcion del evento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la descripcion del evento';
                  }
                  return null;
                },
                controller: _controller,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (_controller.text.isNotEmpty) {
                          final event = EventModel(
                              descEvento: _controller.text,
                              fechaEvento: _selectedDate!.toIso8601String(),
                              completado: false);
                          await databaseHelper!
                              .INSERT('tblEvento', event.toMap());
                          _controller.clear();
                          Navigator.pop(context);
                          _recuperarEventos();
                          setState(() {});
                          flag.setflagListPost();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Evento agregado')),
                          );
                        }
                      },
                      child: Text(
                        'Agregar',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary)),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancelar',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ))
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _deleteEvento(int idInterfaz) async {
    await databaseHelper!.DELETE('tblEvento', idInterfaz, 'idEvento');
    setState(() {
      _eventModel.removeWhere((event) => event.idEvento == idInterfaz);
    });
  }

  void _showDetailsEvent(MyAppointment appointment, FlagsProvider flag) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                'Detalles del evento',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              Text(
                'Descripcion: ${appointment.subject}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Fecha: ${DateFormat.yMMMMd().format(appointment.startTime)}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      eventoCompletado(appointment);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.check,
                        color: Theme.of(context).iconTheme.color),
                    label: Text('Completar',
                        style: Theme.of(context).textTheme.bodyMedium),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      showUpdateEvent(appointment, flag);
                    },
                    icon: Icon(Icons.update,
                        color: Theme.of(context).iconTheme.color),
                    label: Text('Actualizar',
                        style: Theme.of(context).textTheme.bodyMedium),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      showDeleteEvent(appointment, flag);
                    },
                    icon: Icon(Icons.delete,
                        color: Theme.of(context).iconTheme.color),
                    label: Text('Eliminar',
                        style: Theme.of(context).textTheme.bodyMedium),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary),
                  )
                ],
              ),
            ]),
          ),
        );
      },
    );
  }

  void eventoCompletado(MyAppointment appointment) async {
    await databaseHelper!.UPDATE(
        'tblEvento',
        {
          'idEvento': appointment.idEvento,
          'descEvento': appointment.subject,
          'fechaEvento': appointment.startTime.toIso8601String(),
          'completado': true,
        },
        'idEvento');

    int index = _eventModel.indexWhere(
      (e) => e.idEvento == appointment.idEvento,
    );
    _eventModel[index].completado = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Evento completado')),
    );
    setState(() {});
  }

  void showUpdateEvent(MyAppointment appointment, FlagsProvider flag) {
    DateTime dateEvent = appointment.startTime;
    String descEvent = appointment.subject;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar evento',
              style: Theme.of(context).textTheme.titleLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fecha: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    DateFormat.yMMMMd().format(dateEvent),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  IconButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: dateEvent,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100));
                        if (pickedDate != null && pickedDate != dateEvent) {
                          setState(() {
                            dateEvent = pickedDate;
                          });
                        }
                      },
                      icon: Icon(Icons.calendar_today))
                ],
              ),
              SizedBox(height: 16.0),
              TextField(
                style: Theme.of(context).textTheme.bodyLarge,
                decoration:
                    InputDecoration(labelText: 'Descripcion del evento'),
                onChanged: (value) {
                  descEvent = value;
                },
                controller: TextEditingController(text: descEvent),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                      onPressed: () async {
                        await databaseHelper!.UPDATE(
                            'tblEvento',
                            {
                              'idEvento': appointment.idEvento,
                              'descEvento': descEvent,
                              'fechaEvento': dateEvent.toIso8601String(),
                              'completado': appointment.completado
                            },
                            'idEvento');
                        setState(() {
                          appointment.subject = descEvent;
                          appointment.startTime = dateEvent;
                          appointment.endTime = dateEvent;
                        });
                        Navigator.pop(context);
                        _recuperarEventos();
                        flag.setflagListPost();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Cambios guardados')),
                        );
                      },
                      icon: Icon(Icons.save,
                          color: Theme.of(context).iconTheme.color),
                      label: Text('Guardar',
                          style: Theme.of(context).textTheme.bodyMedium),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary)),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.cancel,
                        color: Theme.of(context).iconTheme.color),
                    label: Text('Cancelar',
                        style: Theme.of(context).textTheme.bodyMedium),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary),
                  )
                ],
              )
            ],
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        );
      },
    );
  }

  void showDeleteEvent(MyAppointment appointment, FlagsProvider flag) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Eliminar evento',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            '¿Estas seguro que deseas eliminar este evento?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await databaseHelper!
                    .DELETE('tblEvento', appointment.idEvento, 'idEvento');
                Navigator.pop(context);
                _recuperarEventos();
                flag.setflagListPost();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Evento eliminado')));
              },
              child: Text('Eliminar',
                  style: Theme.of(context).textTheme.bodyMedium),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar',
                  style: Theme.of(context).textTheme.bodyMedium),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary),
            )
          ],
        );
      },
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<EventModel> eventModel) {
    appointments = eventModel.map((event) {
      DateTime dateTime = DateTime.parse(event.fechaEvento!);
      final DateTime today = DateTime.now();
      final DateTime twoDaysAhead = today.add(Duration(days: 2));
      Color color;

      if (isToday(dateTime)) {
        color = Colors.green;
      } else if (dateTime.isBefore(DateTime.now()) &&
          event.completado! == true) {
        color = Colors.green;
      } else if (dateTime.isBefore(DateTime.now()) &&
          event.completado! == false) {
        color = Colors.red;
      } else if (dateTime.difference(DateTime.now()).inDays < 2) {
        color = Colors.yellow;
      } else {
        color = Colors.blue;
      }

      return MyAppointment(
          startTime: dateTime,
          endTime: dateTime,
          subject: event.descEvento!,
          isAllDay: true,
          color: color,
          completado: event.completado ?? false,
          idEvento: event.idEvento!);
    }).toList();
  }

  bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }
}

class MyAppointment extends Appointment {
  bool completado;
  int idEvento;

  MyAppointment(
      {required DateTime startTime,
      required DateTime endTime,
      required String subject,
      bool isAllDay = false,
      Color? color,
      this.completado = false,
      required this.idEvento})
      : super(
          startTime: startTime,
          endTime: endTime,
          subject: subject,
          isAllDay: isAllDay,
          color: color!,
        );
}
