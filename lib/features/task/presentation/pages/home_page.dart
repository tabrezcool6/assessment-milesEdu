import 'dart:ui';

import 'package:assessment_miles_edu/core/common/widgets/loader.dart';
import 'package:assessment_miles_edu/core/utils.dart';
import 'package:assessment_miles_edu/features/auth/domain/usecases/auth_sign_out_usecase.dart';
import 'package:assessment_miles_edu/features/auth/presentation/pages/sign_in_page.dart';
import 'package:assessment_miles_edu/features/task/domain/entity/task_entity.dart';
import 'package:assessment_miles_edu/features/task/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:assessment_miles_edu/features/task/presentation/pages/add_task_page.dart';
import 'package:assessment_miles_edu/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:assessment_miles_edu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:assessment_miles_edu/features/task/presentation/pages/view_task_page.dart';
import 'package:assessment_miles_edu/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:restart_app/restart_app.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String uid = '';
  @override
  void initState() {
    super.initState();

    /// Get the current user's UID from the AuthBloc state
    uid = (context.read<AuthBloc>().state as AuthSuccess).uid;

    /// Fetch tasks for the user when the page is initialized
    context.read<TaskBloc>().add(TaskReadEvent(userUid: uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          'Tasks',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        actions: [
          /// Log out button
          IconButton(
            onPressed:
                () => Utils.singleBtnPopAlertDialogBox(
                  context: context,
                  title: 'Confirm Log Out?',
                  desc: '',
                  onTap1: () {
                    context.read<AuthBloc>().add(AuthSignOutEvent());
                    Utils.showSnackBar(context, 'Logged out Successfully');

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                      (route) => false,
                    );
                  },
                ),
            icon: const Icon(Icons.logout_rounded, color: Colors.red),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade500, Colors.indigo.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            BlocConsumer<TaskBloc, TaskState>(
              listener: (context, state) {
                if (state is TaskFailure) {
                  Utils.showSnackBar(context, state.message);
                } else if (state is TaskUpdateSuccess) {
                  Utils.showSnackBar(context, 'Task updated successfully');

                  context.read<TaskBloc>().add(TaskReadEvent(userUid: uid));
                } else if (state is TaskDeleteSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task deleted successfully!')),
                  );
                  context.read<TaskBloc>().add(TaskReadEvent(userUid: uid));
                }
              },
              builder: (context, state) {
                if (state is TaskLoading) {
                  return Expanded(child: const Center(child: Loader()));
                } else if (state is TaskFailure) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                } else if (state is TaskReadSuccess) {
                  final tasks = state.tasks;

                  // Group tasks by date
                  final Map<String, List<TaskEntity>> groupedTasks = {};
                  for (var task in tasks) {
                    final dateKey = DateFormat(
                      'yyyy-MM-dd',
                    ).format(task.dueDate);
                    if (!groupedTasks.containsKey(dateKey)) {
                      groupedTasks[dateKey] = [];
                    }
                    groupedTasks[dateKey]!.add(task);
                  }

                  final groupedEntries = groupedTasks.entries.toList();
                  print('//////////// Grouped Entries: $groupedEntries');

                  if (groupedEntries.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'No tasks available',
                          style: TextStyle(fontSize: 20, color: Colors.white70),
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: groupedEntries.length,
                      itemBuilder: (context, groupIndex) {
                        final date = groupedEntries[groupIndex].key;
                        final tasks = groupedEntries[groupIndex].value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date headline
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Text(
                                DateFormat(
                                  'EEEE, MMM d',
                                ).format(DateTime.parse(date)),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            // Tasks for the date
                            ...tasks.map((task) {
                              // final index = tasks.indexOf(task);
                              return Dismissible(
                                key: Key(task.title),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  context.read<TaskBloc>().add(
                                    TaskDeleteEvent(
                                      userUid: uid,
                                      taskUid: task.id,
                                    ),
                                  );
                                },
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                ViewTaskPage(taskData: task),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 10,
                                        sigmaY: 10,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(
                                              0.3,
                                            ),
                                            width: 1.5,
                                          ),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 16,
                                        ),
                                        child: ListTile(
                                          leading: Checkbox(
                                            value: task.isCompleted,
                                            onChanged: (value) {
                                              // Update the task's completion status
                                              context.read<TaskBloc>().add(
                                                TaskUpdateEvent(
                                                  userUid: uid,
                                                  taskUid: task.id,
                                                  title: task.title,
                                                  description: task.description,
                                                  dueDate: task.dueDate,
                                                  isCompleted: value,
                                                ),
                                              );
                                            },
                                            activeColor: Colors.indigo.shade400,
                                          ),
                                          title: Text(
                                            task.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 18,
                                              decoration:
                                                  // false
                                                  task.isCompleted
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : TextDecoration.none,
                                              color:
                                                  // false
                                                  task.isCompleted
                                                      ? Colors.white54
                                                      : Colors.white,
                                            ),
                                          ),
                                          subtitle: Text(
                                            task.description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white60,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      },
                    ),
                  );

                  // return _buildTaskList(groupedEntries, todos0);
                } else {
                  return Expanded(
                    child: const Center(child: Text('No tasks available')),
                  );
                }
              },
            ),

            // Create Task Button
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTaskPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.indigo.shade400,
                  elevation: 5,
                ),
                child: Text(
                  "Add Task",
                  style: GoogleFonts.varela(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
