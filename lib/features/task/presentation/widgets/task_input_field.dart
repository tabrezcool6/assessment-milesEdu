import 'package:flutter/material.dart';

class TaskInputField extends StatelessWidget {
  const TaskInputField({
    required this.title,
    required this.hint,
    required this.titleController,
    this.maxLines ,
    this.focusNode,
    super.key,
  });
  final String title;
  final String hint;
  final int? maxLines;
  final TextEditingController titleController;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // Title Label
        Text(
          title,
          // 'Title',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),

        // Title TextField
        TextFormField(
          controller: titleController,
          focusNode: focusNode,
          autofocus: true,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            hintText: hint, //'Enter task title',
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please ${hint.toLowerCase()}';
            }
            return null;
          },
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
