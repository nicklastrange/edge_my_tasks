import '../Repository/Response/event.dart';
// lightweight view model — no external packages required

class EventViewModel {
  final String? id;
  final String title;
  final String? description;
  final String categoryName;
  final List<String> groups;

  EventViewModel({this.id, required this.title, this.description, required this.categoryName, required this.groups});

  factory EventViewModel.fromModel(Event e) => EventViewModel(
        id: e.id,
        title: e.title,
        description: e.description,
        categoryName: e.category.name.toString().split('.').last,
        groups: e.groups?.map((g) => g.toString().split('.').last).toList() ?? [],
      );
}
