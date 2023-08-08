class ShoppingItem {
  final String title;
  final bool isChecked;

  ShoppingItem({
    required this.title,
    required this.isChecked,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'isChecked': isChecked,
    };
  }

  factory ShoppingItem.fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      title: map['title'] as String,
      isChecked: map['isChecked'] as bool,
    );
  }

  ShoppingItem copyWith({
    String? title,
    bool? isChecked,
  }) {
    return ShoppingItem(
      title: title ?? this.title,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
