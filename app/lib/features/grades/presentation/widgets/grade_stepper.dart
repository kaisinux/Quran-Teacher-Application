import 'package:flutter/material.dart';

import '../../../../core/ui/formatters.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../domain/grade_validator.dart';

/// [-0.25] [ 8.75 ] [+0.25]. Tapping the value opens a decimal keypad.
///
/// From "--" (not evaluated), either button starts at 10, the most common
/// grade; defaults are never prefilled (rule §11), this only happens on tap.
class GradeStepper extends StatelessWidget {
  const GradeStepper({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.compact = false,
  });

  final String label;
  final double? value;
  final ValueChanged<double?> onChanged;
  final bool enabled;
  final bool compact;

  void _step(double delta) {
    final current = value;
    if (current == null) {
      onChanged(GradeValidator.maxGrade);
      return;
    }
    final next = (current + delta).clamp(GradeValidator.minGrade, GradeValidator.maxGrade);
    onChanged(next.toDouble());
  }

  Future<void> _edit(BuildContext context) async {
    final result = await showGradeInputDialog(context, label: label, initial: value);
    if (result != null) onChanged(result.value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final size = compact ? 40.0 : 56.0;
    final current = value;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.outlined(
          tooltip: l10n.decrease,
          constraints: BoxConstraints.tightFor(width: size, height: size),
          onPressed: enabled && (current == null || current > GradeValidator.minGrade)
              ? () => _step(-GradeValidator.step)
              : null,
          icon: const Icon(Icons.remove),
        ),
        const SizedBox(width: 8),
        Semantics(
          button: true,
          label: '$label ${formatGrade(context, value)}',
          child: InkWell(
            onTap: enabled ? () => _edit(context) : null,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: compact ? 64 : 88,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.outline),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                formatGrade(context, value),
                style: (compact
                        ? Theme.of(context).textTheme.titleMedium
                        : Theme.of(context).textTheme.headlineSmall)
                    ?.copyWith(
                  color: enabled ? null : Theme.of(context).disabledColor,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton.outlined(
          tooltip: l10n.increase,
          constraints: BoxConstraints.tightFor(width: size, height: size),
          onPressed: enabled && (current == null || current < GradeValidator.maxGrade)
              ? () => _step(GradeValidator.step)
              : null,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

/// Wrapper so "--" (null) can be distinguished from "dialog cancelled".
class GradeInputResult {
  const GradeInputResult(this.value);
  final double? value;
}

Future<GradeInputResult?> showGradeInputDialog(
  BuildContext context, {
  required String label,
  required double? initial,
}) {
  return showDialog<GradeInputResult>(
    context: context,
    builder: (context) => _GradeInputDialog(label: label, initial: initial),
  );
}

class _GradeInputDialog extends StatefulWidget {
  const _GradeInputDialog({required this.label, required this.initial});
  final String label;
  final double? initial;

  @override
  State<_GradeInputDialog> createState() => _GradeInputDialogState();
}

class _GradeInputDialogState extends State<_GradeInputDialog> {
  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _controller = TextEditingController(
      text: initial == null ? '' : initial.toString().replaceAll(RegExp(r'\.0$'), ''),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    try {
      final value = GradeValidator.parseGradeInput(_controller.text);
      Navigator.pop(context, GradeInputResult(value));
    } on FormatException {
      setState(() => _error = AppLocalizations.of(context).issueInvalidGrade);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(widget.label),
      content: TextField(
        controller: _controller,
        autofocus: true,
        textDirection: TextDirection.ltr,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          hintText: l10n.gradeInputHint,
          errorText: _error,
        ),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, const GradeInputResult(null)),
          child: Text('-- (${l10n.notEvaluated})'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(l10n.confirm)),
      ],
    );
  }
}
