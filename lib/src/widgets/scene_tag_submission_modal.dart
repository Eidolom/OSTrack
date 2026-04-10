import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_providers.dart';
import '../ostrack_catalog.dart';
import '../ostrack_theme.dart';

typedef Track = ActiveTrackEntry;

enum TagFidelity { description, approximate, exact }

class SceneTagSubmissionModal extends ConsumerStatefulWidget {
  const SceneTagSubmissionModal({
    super.key,
    required this.track,
  });

  final Track track;

  @override
  ConsumerState<SceneTagSubmissionModal> createState() =>
      _SceneTagSubmissionModalState();
}

class _SceneTagSubmissionModalState
    extends ConsumerState<SceneTagSubmissionModal> {
  TagFidelity _selectedFidelity = TagFidelity.description;
  final _descriptionController = TextEditingController();
  final _contextController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    _contextController.dispose();
    super.dispose();
  }

  Future<void> _submitTag() async {
    if (_descriptionController.text.trim().isEmpty) {
      return;
    }

    setState(() => _isSubmitting = true);

    // Keep the provider dependency live for queue integration in the next step.
    ref.read(mediaRepositoryProvider);

    await Future<void>.delayed(const Duration(milliseconds: 800));

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Scene tagged! +10 Contributor Points',
          style: TextStyle(color: OstrackColors.background),
        ),
        backgroundColor: OstrackColors.gold,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: bottomInset + 24,
      ),
      decoration: BoxDecoration(
        color: OstrackColors.backgroundAlt,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'CATALOG A MEMORY',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    letterSpacing: 2.0,
                    color: OstrackColors.teal,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'When does this track play?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.track.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
            const SizedBox(height: 24),
            _buildFidelitySelector(),
            const SizedBox(height: 24),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _buildInputFields(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitTag,
                style: ElevatedButton.styleFrom(
                  backgroundColor: OstrackColors.gold,
                  foregroundColor: OstrackColors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black87,
                        ),
                      )
                    : const Text(
                        'Submit Scene Tag',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFidelitySelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildFidelityOption(
            TagFidelity.description,
            'Memory',
            Icons.cloud_outlined,
          ),
          _buildFidelityOption(
            TagFidelity.approximate,
            'Chapter',
            Icons.menu_book_outlined,
          ),
          _buildFidelityOption(
            TagFidelity.exact,
            'Exact',
            Icons.timer_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildFidelityOption(
    TagFidelity fidelity,
    String label,
    IconData icon,
  ) {
    final isSelected = _selectedFidelity == fidelity;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFidelity = fidelity;
            _contextController.clear();
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color:
                isSelected ? Colors.white.withValues(alpha: 0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white54,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white54,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_selectedFidelity != TagFidelity.description) ...[
          Text(
            _selectedFidelity == TagFidelity.approximate
                ? 'Episode / Level Name'
                : 'Timestamp (MM:SS)',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _contextController,
            style: const TextStyle(color: Colors.white),
            keyboardType: _selectedFidelity == TagFidelity.exact
                ? TextInputType.datetime
                : TextInputType.text,
            decoration: InputDecoration(
              hintText: _selectedFidelity == TagFidelity.approximate
                  ? 'e.g. Episode 7, Crumbling Farum Azula'
                  : 'e.g. 02:14',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        const Text(
          'Scene Context',
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _descriptionController,
          style: const TextStyle(color: Colors.white),
          maxLines: 3,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Describe what is happening on screen...',
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
