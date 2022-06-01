final String tableItems = 'Items';

class ItemFields {
  static final List<String> values = [
    /// Add all fields
    id, title, description, expaireDate
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String expaireDate = 'expaireDate';
}

class Item {
  final int? id;
  final String title;
  final String description;
  final String expaireDate;
  Item({
    this.id,
    required this.title,
    required this.description,
    required this.expaireDate,
  });

  Item copy({
    int? id,
    String? title,
    String? description,
    String? expaireDate,
  }) =>
      Item(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        expaireDate: expaireDate ?? this.expaireDate,
      );

  static Item fromJson(Map<String, Object?> json) => Item(
        id: json[ItemFields.id] as int?,
        title: json[ItemFields.title] as String,
        description: json[ItemFields.description] as String,
        expaireDate: json[ItemFields.expaireDate] as String,
      );

  Map<String, Object?> toJson() => {
        ItemFields.id: id,
        ItemFields.title: title,
        ItemFields.description: description,
        ItemFields.expaireDate: expaireDate,
      };
}
