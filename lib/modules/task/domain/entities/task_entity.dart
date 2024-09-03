class TaskEnitity {
  final String? id;
  final String? authorId;
  final String? authorEmail;
  final String? title;
  final String? description;
  final List<String>? selectedCateories;
  final bool? isCompleted;

  TaskEnitity({
    required this.id,
    required this.authorId,
    required this.authorEmail,
    required this.title,
    required this.selectedCateories,
    required this.description,
    required this.isCompleted,
  });
}
