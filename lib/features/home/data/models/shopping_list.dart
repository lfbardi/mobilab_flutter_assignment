import 'package:flutter/foundation.dart';

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

  @override
  bool operator ==(covariant ShoppingList other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ items.hashCode;
}
