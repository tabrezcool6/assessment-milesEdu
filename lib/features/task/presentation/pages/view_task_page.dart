import 'dart:ui';

import 'package:assessment_miles_edu/core/common/widgets/loader.dart';
import 'package:assessment_miles_edu/core/utils.dart';
import 'package:assessment_miles_edu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:assessment_miles_edu/features/task/domain/entity/task_entity.dart';
import 'package:assessment_miles_edu/features/task/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:assessment_miles_edu/features/task/presentation/pages/add_task_page.dart';
import 'package:assessment_miles_edu/features/task/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ViewTaskPage extends StatelessWidget {
  final TaskEntity taskData;

  const ViewTaskPage({super.key, required this.taskData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        backgroundColor: Colors.cyan.shade500,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade500, Colors.indigo.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is TaskFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is TaskDeleteSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task deleted successfully!')),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is TaskLoading) {
              return Loader();
            }
            return Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  width: 360,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        taskData.title ?? 'No Title',
                        style: GoogleFonts.varela(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Subtitle
                      Text(
                        taskData.description ?? 'No Description',
                        style: GoogleFonts.varela(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Task Status
                      Row(
                        children: [
                          Icon(
                            taskData.isCompleted == true
                                ? Icons.check_circle_outline
                                : Icons.error_outline,
                            color: Colors.white54,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Status: ${taskData.isCompleted == true ? 'Completed' : 'Pending'}",
                            style: GoogleFonts.varela(
                              fontSize: 16,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Date Created
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white54,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Created on: ${DateFormat('EEEE, MMM d, yyyy').format(taskData.dueDate ?? DateTime.now())}',
                            style: GoogleFonts.varela(
                              fontSize: 16,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Edit Button
                          ElevatedButton.icon(
                            onPressed: () {
                              // Add your update functionality here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          AddTaskPage(taskData: taskData),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit, color: Colors.white),
                            label: const Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.indigo.shade400,
                              elevation: 5,
                            ),
                          ),

                          // Delete Button
                          ElevatedButton.icon(
                            onPressed: () {
                              // Add your delete functionality here

                              context.read<TaskBloc>().add(
                                TaskDeleteEvent(
                                  userUid:
                                      (context.read<AuthBloc>().state
                                              as AuthSessionSuccess)
                                          .uid,
                                  taskUid: taskData.id,
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete, color: Colors.white),
                            label: const Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.red.shade400,
                              elevation: 5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
