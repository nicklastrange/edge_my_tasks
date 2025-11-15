import 'package:flutter/material.dart';
import 'styles.dart';
import '../Repository/Http/http_event_management_repository.dart';
import '../Repository/Request/event_create_request.dart' as req;
import '../Repository/Response/enums.dart';

class CreateEventPage extends StatefulWidget {
  final VoidCallback? onBack;
  const CreateEventPage({super.key, this.onBack});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String categoryName = 'HR';
  List<String> groups = [];
  DateTime? deadline;
  int priority = 1;
  bool _submitting = false;

  final categories = [
    {'name': 'SECURITY', 'required': true, 'policy': '24h,3h'},
    {'name': 'HR', 'required': true, 'policy': '24h,3h,1h'},
    {'name': 'COMPLIANCE', 'required': false, 'policy': '24h'},
    {'name': 'ONBOARDING', 'required': true, 'policy': '24h,3h'},
  ];

  final availableGroups = [
    'Wszyscy pracownicy',
    'Dział IT',
    'Dział sprzedaży',
    'Marketing',
    'Produkcja',
  ];

  void _toggleGroup(String g) {
    setState(() {
      if (groups.contains(g)) {
        groups.remove(g);
      } else {
        groups.add(g);
      }
    });
  }

  Future<void> _pickDeadline() async {
    final now = DateTime.now();
    final dt = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 3)),
    );
    if (dt != null) {
      if (!mounted) return; // ensure widget still mounted before using context again
      final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (time != null) {
        if (!mounted) return;
        setState(() {
          deadline = DateTime(dt.year, dt.month, dt.day, time.hour, time.minute);
        });
      }
    }
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _formKey.currentState?.save();
    setState(() => _submitting = true);

    // Map local category string to CategoryDto (best-effort)
    CategoryDto mapCategory(String name) {
      final normalized = name.toUpperCase();
      try {
        return CategoryDto.values.firstWhere((e) => e.name == normalized);
      } catch (_) {
        return CategoryDto.GENERAL;
      }
    }

    // Explicit mapping from available group labels to GroupEnum
    List<GroupEnum> mapGroups(List<String> gs) {
      const mapping = {
        'Wszyscy pracownicy': GroupEnum.uop,
        'Dział IT': GroupEnum.dev,
        'Dział sprzedaży': GroupEnum.sales,
        'Marketing': GroupEnum.b2b,
        'Produkcja': GroupEnum.backoffice,
      };
      final out = <GroupEnum>[];
      for (final g in gs) {
        final enumVal = mapping[g];
        if (enumVal != null) out.add(enumVal);
      }
      return out;
    }

    final request = req.EventCreateRequest(
      category: mapCategory(categoryName),
      title: title,
      description: description.isEmpty ? null : description,
      groups: mapGroups(groups),
    );

    final repo = HttpEventManagementRepository(baseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080'));
    repo.createEvent(request).then((created) {
      if (!mounted) return;
      setState(() => _submitting = false);
      showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Wydarzenie zostało utworzone!'),
          content: Text('Tytuł: ${created.title}\nKategoria: ${created.category.name.toString().split('.').last}'),
          actions: [TextButton(onPressed: () {
            Navigator.of(context).pop();
            widget.onBack?.call();
          }, child: const Text('OK'))],
        ),
      );
    }).catchError((e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      showDialog<void>(context: context, builder: (_) => AlertDialog(title: const Text('Błąd'), content: Text(e.toString()), actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))]));
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedCat = categories.firstWhere((c) => c['name'] == categoryName, orElse: () => {});
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPagePadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  IconButton(
                    onPressed: widget.onBack,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 8),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                    Text('Utwórz nowe wydarzenie', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4),
                    Text('Wydarzenia generują zadania dla wybranych grup', style: TextStyle(color: Colors.grey)),
                  ])
                ]),

                const SizedBox(height: 16),

                // Title
                _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Tytuł wydarzenia', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'np. Szkolenie BHP Q4'),
                    onSaved: (v) => title = v ?? '',
                    validator: (v) => (v == null || v.isEmpty) ? 'Wprowadź tytuł' : null,
                  ),
                ])),

                const SizedBox(height: 12),

                // Description
                _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Opis wydarzenia', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextFormField(
                    maxLines: 4,
                    decoration: const InputDecoration(hintText: 'Dodaj szczegóły wydarzenia...'),
                    onSaved: (v) => description = v ?? '',
                  ),
                ])),

                const SizedBox(height: 12),

                // Category
                _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Kategoria', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, runSpacing: 8, children: categories.map((c) {
                    final name = c['name'] as String;
                    final isSelected = categoryName == name;
                    return ChoiceChip(
                      label: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [Text(name, style: TextStyle(color: isSelected ? Colors.white : Colors.black)), const SizedBox(width: 8), if (c['required'] as bool) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFF0A020), borderRadius: BorderRadius.circular(20)), child: const Text('Obowiązkowe', style: TextStyle(color: Colors.white, fontSize: 12)),)]),
                        const SizedBox(height: 4),
                        Text('Przypomnienia: ${c['policy']}', style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black54)),
                      ]),
                      selected: isSelected,
                      onSelected: (_) => setState(() => categoryName = name),
                      selectedColor: const Color(0xFF1B4E9B),
                      checkmarkColor: isSelected ? Colors.white : Colors.black,
                    );
                  }).toList()),

                  if (selectedCat.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0x1A1B4E9B), borderRadius: BorderRadius.circular(12)),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Polityka powiadomień: ${selectedCat['policy']}', style: const TextStyle(fontSize: 13)),
                        if (selectedCat['required'] as bool)
                          Padding(padding: const EdgeInsets.only(top: 8), child: Text('⚠️ To zadanie jest obowiązkowe - pracownicy nie mogą go odrzucić', style: TextStyle(color: Colors.orange[700]))),
                      ]),
                    ),
                ])),

                const SizedBox(height: 12),

                // Deadline
                _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Termin wykonania', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _pickDeadline,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
                      child: Text(deadline == null ? 'Wybierz datę i godzinę' : deadline.toString()),
                    ),
                  ),
                ])),

                const SizedBox(height: 12),

                // Groups
                _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Przypisz do grup (${groups.length} wybrano)', style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Column(children: availableGroups.map((g) => InkWell(
                    onTap: () => _toggleGroup(g),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(color: groups.contains(g) ? const Color(0x1A1B4E9B) : Colors.white, border: Border.all(color: groups.contains(g) ? const Color(0xFF1B4E9B) : Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(g), if (groups.contains(g)) Container(width: 20, height: 20, decoration: const BoxDecoration(color: Color(0xFFF0A020), shape: BoxShape.circle), child: const Icon(Icons.add, size: 14, color: Colors.white))]),
                    ),
                  )).toList())
                ])),

                const SizedBox(height: 12),

                // Priority slider
                _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Priorytet: ${['Niski', 'Średni', 'Wysoki'][priority]}', style: const TextStyle(fontWeight: FontWeight.w600)),
                  Slider(value: priority.toDouble(), min: 0, max: 2, divisions: 2, label: ['Niski', 'Średni', 'Wysoki'][priority], onChanged: (v) => setState(() => priority = v.toInt())),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Niski', style: TextStyle(fontSize: 12)), Text('Średni', style: TextStyle(fontSize: 12)), Text('Wysoki', style: TextStyle(fontSize: 12))])
                ])),

                const SizedBox(height: 16),

                ElevatedButton(onPressed: _submit, style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(54), backgroundColor: const Color(0xFF1B4E9B)), child: const Text('Utwórz wydarzenie i wygeneruj zadania', style: TextStyle(color: Colors.white),)),
                if (_submitting) const Padding(padding: EdgeInsets.only(top: 12), child: Center(child: CircularProgressIndicator())),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) => Container(padding: const EdgeInsets.all(14), decoration: cardDecoration(), child: child);
}
