// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  final String title;
  final String id;
  final String subtitle;
  final String date;
  bool isDone;
  bool isDeleted;
  bool isFavorite;
  Task({
    this.title = '',
    required this.id,
    this.subtitle = '',
    required this.date,
    this.isDone = false,
    this.isDeleted = false,
    this.isFavorite = false,
  });

  Task copyWith({
    String? title,
    String? subtitle,
    String? date,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Task(
      title: title ?? this.title,
      id: id,
      subtitle: subtitle ?? this.subtitle,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        title: json['title'],
        id: json['id'],
        subtitle: json['subtitle'],
        date: json['date'],
        isDone: json['isDone'],
        isDeleted: json['isDeleted'],
        isFavorite: json['isFavorite']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'subtitle': subtitle,
      'date': date,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite
    };
  }

  @override
  String toString() {
    return '''Task: {
			title: $title\n
			id: $id\n
			subtitle: $subtitle\n
			date: $date\n
			isDone: $isDone\n
			isDeleted: $isDeleted\n
			isFavorite: $isFavorite\n
		}''';
  }
}
