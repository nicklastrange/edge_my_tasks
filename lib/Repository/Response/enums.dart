
import 'package:json_annotation/json_annotation.dart';

part 'enums.g.dart';

@JsonEnum(alwaysCreate: true)
enum GroupEnum {
	@JsonValue('UoP')
		uop,
	@JsonValue('SALES')
	sales,
	@JsonValue('BACKOFFICE')
	backoffice,
	@JsonValue('B2B')
	b2b,
	@JsonValue('DEV')
	dev,
	@JsonValue('TL')
	tl,
	@JsonValue('QA')
	qa,
}

@JsonEnum(alwaysCreate: true)
enum NotificationChannel { @JsonValue('EMAIL') email, @JsonValue('SMS') sms, @JsonValue('WHATSAPP') whatsapp, @JsonValue('MS_TEAMS') msTeams }


@JsonEnum(alwaysCreate: true)
enum CategoryDto {
	@JsonValue('SECURITY') SECURITY,
	@JsonValue('SALES') SALES,
	@JsonValue('GENERAL') GENERAL,
	@JsonValue('ONBOARDING') ONBOARDING,
	@JsonValue('TRAINING') TRAINING,
	@JsonValue('PARTY') PARTY,
	@JsonValue('HR') HR,
	@JsonValue('IT') IT,
	@JsonValue('COMPLIANCE') COMPLIANCE,
}

