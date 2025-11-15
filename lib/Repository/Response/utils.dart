import 'enums.dart';

GroupEnum groupFromString(String s) {
	switch (s) {
		case 'UoP':
		case 'UOP':
		case 'LOB':
			return GroupEnum.uop;
		case 'SALES':
		case 'sales':
			return GroupEnum.sales;
		case 'BACKOFFICE':
		case 'backoffice':
			return GroupEnum.backoffice;
		case 'B2B':
			return GroupEnum.b2b;
		case 'DEV':
			return GroupEnum.dev;
		case 'TL':
			return GroupEnum.tl;
		case 'QA':
			return GroupEnum.qa;
		default:
			return GroupEnum.uop;
	}
}

NotificationChannel notificationFromString(String s) {
	switch (s) {
		case 'EMAIL':
		case 'email':
			return NotificationChannel.email;
		case 'SMS':
		case 'sms':
			return NotificationChannel.sms;
		case 'WHATSAPP':
		case 'whatsapp':
			return NotificationChannel.whatsapp;
		case 'MS_TEAMS':
		case 'ms_teams':
			return NotificationChannel.msTeams;
		default:
			return NotificationChannel.email;
	}
}
