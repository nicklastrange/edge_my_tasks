import 'package:json_annotation/json_annotation.dart';
import 'category.dart';
import 'enums.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true)
class Event {
      final String? id;
      final Category category;
      final String title;
      final String? description;
      final List<GroupEnum>? groups;

      Event({this.id, required this.category, required this.title, this.description, this.groups});

      factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

      Map<String, dynamic> toJson() => _$EventToJson(this);
}
