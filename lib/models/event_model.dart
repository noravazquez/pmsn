class EventModel {
  int? idEvento;
  String? descEvento;
  DateTime? fechaEvento;
  int? completado;

  EventModel(
      {this.idEvento, this.descEvento, this.fechaEvento, this.completado});

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      idEvento: map['idEvento'],
      descEvento: map['descEvento'],
      fechaEvento: DateTime.parse(map['fechaEvento']),
      completado: map['completado'] == 1 ? 1 : 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idEvento': idEvento,
      'descEvento': descEvento,
      'fechaEvento': fechaEvento,
      'completado': completado == 1 ? 1 : 0,
    };
  }
}
