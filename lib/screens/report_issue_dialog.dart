import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Zeigt einen Dialog zum Melden eines Problems oder einer Anregung an.
///
/// Aus Sicherheitsgründen enthält die App kein GitHub-Zugriffstoken. Statt
/// das Issue direkt per API anzulegen, öffnet der Dialog beim Absenden ein
/// vorausgefülltes neues Issue im Browser — die endgültige Übermittlung
/// erfolgt dort mit dem eigenen GitHub-Konto der Person, die es meldet.
void showReportIssueDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (_) => const _ReportIssueDialog(),
  );
}

enum _ReportKind { bug, idea }

class _ReportIssueDialog extends StatefulWidget {
  const _ReportIssueDialog();

  @override
  State<_ReportIssueDialog> createState() => _ReportIssueDialogState();
}

class _ReportIssueDialogState extends State<_ReportIssueDialog> {
  static const _repoOwner = 'carstenroesner';
  static const _repoName = 'spraytattoo_katalog';

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  _ReportKind _kind = _ReportKind.bug;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim().isEmpty
        ? (_kind == _ReportKind.bug ? 'Problem in der App' : 'Anregung für die App')
        : _titleController.text.trim();
    final label = _kind == _ReportKind.bug ? 'bug' : 'enhancement';

    final uri = Uri.https('github.com', '/$_repoOwner/$_repoName/issues/new', {
      'title': title,
      'body': _descriptionController.text.trim(),
      'labels': label,
    });

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!mounted) return;
    navigator.pop();
    if (!launched) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Der Browser konnte nicht geöffnet werden.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Problem melden'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SegmentedButton<_ReportKind>(
              segments: const [
                ButtonSegment(
                  value: _ReportKind.bug,
                  label: Text('Problem'),
                  icon: Icon(Icons.bug_report_outlined),
                ),
                ButtonSegment(
                  value: _ReportKind.idea,
                  label: Text('Anregung'),
                  icon: Icon(Icons.lightbulb_outline),
                ),
              ],
              selected: {_kind},
              onSelectionChanged: (selection) => setState(() => _kind = selection.first),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titel',
                hintText: 'Kurze Zusammenfassung',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Beschreibung',
                hintText: 'Was ist passiert? Was schlägst du vor?',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Öffnet ein vorausgefülltes GitHub-Issue in deinem Browser, wo du es '
              'final absenden kannst.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Issue öffnen'),
        ),
      ],
    );
  }
}
