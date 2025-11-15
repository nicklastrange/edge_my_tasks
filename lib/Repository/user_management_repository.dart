import 'Response/category.dart';
import 'Response/enums.dart';

abstract class UserManagementRepository {
	/// Get user's category blacklist
	Future<List<Category>> getCategoryBlacklist();

	/// Replace user's category blacklist
	Future<void> putCategoryBlacklist(List<Category> blacklist);

	/// Get user's notification channels
	Future<List<NotificationChannel>> getNotificationChannels();

	/// Replace user's notification channels
	Future<void> putNotificationChannels(List<NotificationChannel> channels);
}

