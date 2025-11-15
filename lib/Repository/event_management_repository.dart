import 'Request/event_create_request.dart' as req;
import 'Response/event.dart';
import 'Response/event_tasks_status.dart';

abstract class EventManagementRepository {
	/// Create new event. Returns created EventDocument.
	Future<Event> createEvent(req.EventCreateRequest request);

	/// Fetch list of events
	Future<List<Event>> getEvents();

	/// Fetch participants/tasks grouped by status for an event
	Future<EventTasksStatus> getParticipantsStatus(String eventId);
}

