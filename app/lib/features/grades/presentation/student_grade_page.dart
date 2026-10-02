import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/app_error.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/ui/formatters.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../data/grades_repository.dart';
import '../domain/grade_validator.dart';
import '../domain/student_grade.dart';
import 'widgets/grade_stepper.dart';

/// Detailed sheet of one student, swipeable to the previous / next student.
class StudentGradePage extends ConsumerStatefulWidget {
  const StudentGradePage({
    super.key,
    required this.sessionId,
    required this.initialIndex,
  });

  final String sessionId;
  final int initialIndex;

  @override
  ConsumerState<StudentGradePage> createState() => _StudentGradePageState();
}

class _StudentGradePageState extends ConsumerState<StudentGradePage> {
  late final PageController _pages = PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _goTo(int index) => _pages.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = ref.watch(sessionGradesProvider(widget.sessionId)).value;
    if (session == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final grades = session.grades;
    final current = grades[_index];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(current.studentName, overflow: TextOverflow.ellipsis),
            Text('${_index + 1} / ${grades.length}',
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
      body: PageView.builder(
        controller: _pages,
        itemCount: grades.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (context, i) => _StudentForm(
          key: ValueKey(grades[i].studentId),
          sessionId: widget.sessionId,
          grade: grades[i],
          enabled: session.isEditable,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _index > 0 ? () => _goTo(_index - 1) : null,
                icon: const Icon(Icons.chevron_left),
                label: Text(l10n.previousStudent),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: _index < grades.length - 1 ? () => _goTo(_index + 1) : null,
                icon: const Icon(Icons.chevron_right),
                label: Text(l10n.nextStudent),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _StudentForm extends ConsumerStatefulWidget {
  const _StudentForm({
    super.key,
    required this.sessionId,
    required this.grade,
    required this.enabled,
  });

  final String sessionId;
  final StudentGrade grade;
  final bool enabled;

  @override
  ConsumerState<_StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends ConsumerState<_StudentForm> {
  late final TextEditingController _remark =
      TextEditingController(text: widget.grade.remark ?? '');
  Timer? _debounce;

  // Captured up front: `ref` may not be used in dispose().
  late final GradesRepository _repo = ref.read(gradesRepositoryProvider);

  @override
  void initState() {
    super.initState();
    _repo; // resolve now
  }

  @override
  void dispose() {
    // Never lose a remark typed just before leaving the page.
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
      _saveRemarkNow();
    }
    _remark.dispose();
    super.dispose();
  }

  Future<void> _save(StudentGrade grade) async {
    try {
      await _repo.updateGrade(widget.sessionId, grade);
    } on AppException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(appErrorMessage(context, e))));
      }
    }
  }

  void _onRemarkChanged(String _) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), _saveRemarkNow);
  }

  void _saveRemarkNow() {
    final text = _remark.text;
    _repo
        .updateGrade(widget.sessionId, widget.grade.copyWith(remark: () => text))
        .ignore();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.statusColors;
    final grade = widget.grade;
    final enabled = widget.enabled;
    final gradesEnabled = enabled && grade.isPresent;
    final issues = GradeValidator.validateStudent(grade)
        .where((i) => i.isBlocking)
        .toList();
    final remarkRequired = GradeValidator.requiresDisciplineRemark(grade);
    final remarkMissing = remarkRequired && grade.normalizedRemark == null;

    Widget gradeRow(String label, double? value, StudentGrade Function(double?) update) =>
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Center(
                child: GradeStepper(
                  label: label,
                  value: grade.isPresent ? value : null,
                  enabled: gradesEnabled,
                  onChanged: (v) => _save(update(v)),
                ),
              ),
            ],
          ),
        );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final issue in issues)
          ListTile(
            leading: Icon(Icons.error, color: colors.danger),
            title: Text(issueMessage(l10n, issue)),
          ),
        Card(
          child: SwitchListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            secondary: Icon(
              grade.isPresent ? Icons.check_circle : Icons.cancel,
              color: grade.isPresent ? colors.success : colors.danger,
              size: 32,
            ),
            title: Text(l10n.fieldPresence),
            subtitle: Text(grade.isPresent ? l10n.present : l10n.absent,
                style: Theme.of(context).textTheme.titleMedium),
            value: grade.isPresent,
            onChanged: enabled
                ? (v) => _save(grade.copyWith(
                    attendance: v ? Attendance.present : Attendance.absent))
                : null,
          ),
        ),
        gradeRow(l10n.fieldHifz, grade.hifz, (v) => grade.copyWith(hifz: () => v)),
        gradeRow(l10n.fieldTajwid, grade.tajwid, (v) => grade.copyWith(tajwid: () => v)),
        gradeRow(l10n.fieldDiscipline, grade.discipline,
            (v) => grade.copyWith(discipline: () => v)),
        const SizedBox(height: 8),
        TextField(
          controller: _remark,
          enabled: enabled,
          minLines: 2,
          maxLines: 5,
          onChanged: _onRemarkChanged,
          decoration: InputDecoration(
            labelText: l10n.fieldRemark,
            hintText: remarkRequired ? l10n.remarkRequiredHint : l10n.remarkHint,
            errorText: remarkMissing ? l10n.issueMissingRemark : null,
          ),
        ),
      ],
    );
  }
}
