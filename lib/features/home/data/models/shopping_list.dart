// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'shopping_item.dart';

class ShoppingList {
  final String? id;
  final String title;
  final List<ShoppingItem> items;

  ShoppingList({
    required this.id,
    required this.title,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory ShoppingList.fromMap(String id, Map<String, dynamic> map) {
    return ShoppingList(
        id: id,
        title: map['title'] as String,
        items: List<ShoppingItem>.from(
            (map['items'] as List).map((x) => ShoppingItem.fromMap(x))));
  }

  ShoppingList copyWith({
    String? id,
    String? title,
    List<ShoppingItem>? items,
  }) {
    return ShoppingList(
      id: id ?? this.id,
      title: title ?? this.title,
      items: items ?? this.items,
    );
  }
}
