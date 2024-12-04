class Item {
  final int? id;
  final String name;

  Item({this.id, required this.name});

  // Ma'lumotlarni map formatiga o'tkazish
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Map-dan obyekt yaratish
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
    );
  }
}
