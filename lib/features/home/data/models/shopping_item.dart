class ShoppingItem {
  final String id;
  final String title;
  final bool isChecked;

  ShoppingItem({
    required this.id,
    required this.title,
    required this.isChecked,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'isChecked': isChecked,
    };
  }

  factory ShoppingItem.fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      id: map['id'] as String,
      title: map['title'] as String,
      isChecked: map['isChecked'] as bool,
    );
  }
}
