import 'package:json_annotation/json_annotation.dart';
import 'enums.dart';

part 'stats_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryCompletionRate {
  final CategoryDto category;
  final double donePercentage;
  final double rejectedPercentage;
  final int total;
  final int done;
  final int rejected;

  CategoryCompletionRate({required this.category, required this.donePercentage, required this.rejectedPercentage, required this.total, required this.done, required this.rejected});

  factory CategoryCompletionRate.fromJson(Map<String, dynamic> json) => _$CategoryCompletionRateFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryCompletionRateToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChannelEffectiveness {
  final NotificationChannel channel;
  final double completionRate;
  final int tasks;

  ChannelEffectiveness({required this.channel, required this.completionRate, required this.tasks});

  factory ChannelEffectiveness.fromJson(Map<String, dynamic> json) => _$ChannelEffectivenessFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelEffectivenessToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChannelPreferenceSlice {
  final NotificationChannel channel;
  final double percentage;
  final int employees;

  ChannelPreferenceSlice({required this.channel, required this.percentage, required this.employees});

  factory ChannelPreferenceSlice.fromJson(Map<String, dynamic> json) => _$ChannelPreferenceSliceFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelPreferenceSliceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StatsResponse {
  final double overallDonePercentage;
  final double overallRejectedPercentage;
  final double pendingPercentage;
  final double expiringSoonPercentage;
  final List<CategoryCompletionRate>? categoryRates;
  final List<String>? alertEmployees;
  final int totalDeliveredNotifications;
  final int totalUniqueClicks;
  final double? averageCompletionHours;
  final List<ChannelEffectiveness>? channelEffectiveness;
  final List<ChannelPreferenceSlice>? channelPreferences;
  final int activeTasksCount;
  final int overdueTasksCount;
  final double completionPercentage;
  final int activeEmployeesCount;

  StatsResponse({required this.overallDonePercentage, required this.overallRejectedPercentage, required this.pendingPercentage, required this.expiringSoonPercentage, this.categoryRates, this.alertEmployees, required this.totalDeliveredNotifications, required this.totalUniqueClicks, this.averageCompletionHours, this.channelEffectiveness, this.channelPreferences, required this.activeTasksCount, required this.overdueTasksCount, required this.completionPercentage, required this.activeEmployeesCount});

  factory StatsResponse.fromJson(Map<String, dynamic> json) => _$StatsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StatsResponseToJson(this);
}
