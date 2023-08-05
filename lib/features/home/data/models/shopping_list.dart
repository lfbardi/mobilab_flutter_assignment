import 'shopping_item.dart';

class ShoppingList {
  final String id;
  final String title;
  final List<ShoppingItem> items;

  ShoppingList({
    required this.id,
    required this.title,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory ShoppingList.fromMap(Map<String, dynamic> map) {
    return ShoppingList(
      id: map['id'] as String,
      title: map['title'] as String,
      items: List<ShoppingItem>.from(
        (map['items'] as List<int>).map<ShoppingItem>(
          (x) => ShoppingItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
