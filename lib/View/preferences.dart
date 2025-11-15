import 'package:flutter/material.dart';
import 'styles.dart';

import '../Repository/Http/http_user_management_repository.dart';
import '../Repository/Response/enums.dart';
import '../Repository/Response/category.dart';

class PreferencesPage extends StatefulWidget {
  final VoidCallback? onBack;
  final String? userId;
  const PreferencesPage({super.key, this.onBack, this.userId});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  bool _loading = true;
  String? _error;

  final Set<NotificationChannel> _channels = {};
  List<Category> _blacklist = [];
  String reminder = '3h';

  late HttpUserManagementRepository _repo;

  @override
  void initState() {
    super.initState();
    _repo = HttpUserManagementRepository(baseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080'), userId: widget.userId);
    _fetchPreferences();
  }

  Future<void> _fetchPreferences() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final channels = await _repo.getNotificationChannels();
      final blacklist = await _repo.getCategoryBlacklist();

      setState(() {
        _channels.clear();
        _channels.addAll(channels);
        _blacklist = blacklist;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  void _toggleChannel(NotificationChannel c) {
    setState(() {
      if (_channels.contains(c)) _channels.remove(c); else _channels.add(c);
    });
  }

  Future<void> _save() async {
    setState(() { _loading = true; _error = null; });
    try {
      await _repo.putNotificationChannels(_channels.toList());
      await _repo.putCategoryBlacklist(_blacklist);
      setState(() { _loading = false; });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ustawienia zapisane')));
    } catch (e) {
      setState(() { _loading = false; _error = e.toString(); });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Błąd zapisu: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget channelRow(Icon icon, String title, String subtitle, NotificationChannel c) {
      final enabled = _channels.contains(c);
      return InkWell(
        onTap: () => _toggleChannel(c),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)), child: icon),
                  const SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w600)), Text(subtitle, style: const TextStyle(color: Colors.grey))])
                ],
              ),
              GestureDetector(
                onTap: () => _toggleChannel(c),
                child: Container(
                  width: 56,
                  height: 28,
                  decoration: BoxDecoration(color: enabled ? const Color(0xFF1B4E9B) : Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
                  child: Align(
                    alignment: enabled ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(margin: const EdgeInsets.all(4), width: 20, height: 20, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: Column(children: [
        Container(color: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(children: [IconButton(onPressed: widget.onBack, icon: const Icon(Icons.arrow_back)), const SizedBox(width: 8), const Text('Ustawienia powiadomień', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))])),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(kPagePadding), child: Column(children: [
          if (_loading) const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 24), child: CircularProgressIndicator()))
          else if (_error != null) Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 24), child: Column(children: [Text('Błąd: $_error', style: const TextStyle(color: Colors.red)), const SizedBox(height: 8), ElevatedButton(onPressed: _fetchPreferences, child: const Text('Ponów'))])))
          else ...[
            Container(padding: const EdgeInsets.all(12), decoration: cardDecoration(), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Kanały powiadomień', style: TextStyle(fontWeight: FontWeight.w600)), const SizedBox(height: 12),
              channelRow(const Icon(Icons.message, color: Color(0xFF1B4E9B)), 'Email', 'Powiadomienia e-mail', NotificationChannel.email),
              const SizedBox(height: 8),
              channelRow(const Icon(Icons.chat, color: Colors.green), 'WhatsApp', 'Wiadomości na WhatsApp', NotificationChannel.whatsapp),
              const SizedBox(height: 8),
              channelRow(const Icon(Icons.smartphone, color: Colors.purple), 'SMS', 'Wiadomości tekstowe', NotificationChannel.sms),
              const SizedBox(height: 8),
              channelRow(const Icon(Icons.work, color: Colors.blueGrey), 'MS Teams', 'Powiadomienia MS Teams', NotificationChannel.msTeams),
            ])),

            const SizedBox(height: 12),
            Container(padding: const EdgeInsets.all(12), decoration: cardDecoration(), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Wykluczone kategorie', style: TextStyle(fontWeight: FontWeight.w600)), const SizedBox(height: 12),
              if (_blacklist.isEmpty) const Text('Brak wykluczonych kategorii')
              else Column(children: _blacklist.map((c) => Container(padding: const EdgeInsets.all(12), margin: const EdgeInsets.only(bottom: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(c.name.toString().split('.').last), IconButton(onPressed: () { setState(() => _blacklist.removeWhere((b) => b.name == c.name)); }, icon: const Icon(Icons.remove_circle_outline))]))).toList()),
            ])),

            const SizedBox(height: 16),
            ElevatedButton(onPressed: _save, style: primaryButtonStyle(), child: const Text('Zapisz ustawienia'))
          ]
        ])))
      ])),
    );
  }

  
}
