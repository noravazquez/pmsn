class EventModel {
  int? idEvent;
  String? dscEvent;
  String? dateEvent;
  bool? complete;

  EventModel({this.idEvent, this.dscEvent, this.dateEvent, this.complete});

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
        idEvent: map['idEvent'],
        dscEvent: map['dscEvent'],
        dateEvent: map['dateEvent'],
        complete: map['complete']);
  }
}
