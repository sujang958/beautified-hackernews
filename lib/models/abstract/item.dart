abstract class Item {
  final int id;
  final String by;
  final int time;
  final String type = '';

  const Item({
    required this.id,
    required this.by,
    required this.time,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
