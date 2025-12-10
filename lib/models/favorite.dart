class Favorite {
  int? id;
  String city;
  String note;

  Favorite({this.id, required this.city, this.note = ""});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'city': city, 'note': note};
    if (id != null) map['id'] = id;
    return map;
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'],
      city: map['city'],
      note: map['note'] ?? "",
    );
  }
}
