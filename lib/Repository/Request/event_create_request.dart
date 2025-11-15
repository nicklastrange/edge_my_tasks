import 'package:json_annotation/json_annotation.dart';
import '../Response/enums.dart';

part 'event_create_request.g.dart';

@JsonSerializable(explicitToJson: true)
class EventCreateRequest {
  final CategoryDto category;
  final String title;
  final String? description;
  final List<GroupEnum> groups;

  EventCreateRequest({required this.category, required this.title, this.description, this.groups = const []});

  factory EventCreateRequest.fromJson(Map<String, dynamic> json) => _$EventCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EventCreateRequestToJson(this);
}
