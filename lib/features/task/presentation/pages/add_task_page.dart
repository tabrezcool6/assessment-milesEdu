import 'package:assessment_miles_edu/core/common/widgets/loader.dart';
import 'package:assessment_miles_edu/core/utils.dart';
import 'package:assessment_miles_edu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:assessment_miles_edu/features/task/domain/entity/task_entity.dart';
import 'package:assessment_miles_edu/features/task/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:assessment_miles_edu/features/task/presentation/pages/home_page.dart';
import 'package:assessment_miles_edu/features/task/presentation/widgets/task_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskPage extends StatefulWidget {
  final TaskEntity? taskData;

  const AddTaskPage({super.key, this.taskData});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String userUid = '';

  TaskEntity? taskData;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    // Get the current user's UID from the AuthBloc state
    userUid = (context.read<AuthBloc>().state as AuthSuccess).uid;

    if (widget.taskData != null) {
      // If a taskData is provided, initialize the taskData variable
      taskData = widget.taskData!;
      // If a taskData is provided, populate the controllers with its data
      _titleController.text = widget.taskData!.title ?? '';
      _descriptionController.text = widget.taskData!.description ?? '';
    }
  }

  void _createTask() {
    print('///// CREATE TASk');
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // Dismiss the keyboard

      context.read<TaskBloc>().add(
        TaskCreateEvent(
          userUid: userUid,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          date: DateTime.now(),
        ),
      );
    }
  }

  void _updateTask() async {
    print('///// update');

    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();

    /// if none value is changed,
    ///  just Navigating back to Home Screen without any API call
    if (title == taskData!.title && description == taskData!.description) {
      Utils.showSnackBar(context, 'Task created successfully');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
        (route) => false,
      );
      return;
    }

    /// Else validating the data
    if (_formKey.currentState!.validate()) {
      /// esle making an API call with passing the changed values
      context.read<TaskBloc>().add(
        TaskUpdateEvent(
          userUid: userUid,
          taskUid: taskData!.id,
          title: title,
          description: description,
          isCompleted: false,
          dueDate: taskData!.dueDate,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(taskData != null ? 'Update Task' : 'Add Task'),
        backgroundColor: Colors.cyan.shade500,
        elevation: 0,
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskFailure) {
            Utils.showSnackBar(context, state.message);
          } else if (state is TaskCreateSuccess) {
            Utils.showSnackBar(context, 'Task created successfully');

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
              (route) => false,
            );
          } else if (state is TaskUpdateSuccess) {
            Utils.showSnackBar(context, 'Task updated successfully');

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
              (route) => false,
            );
          }
        },
        builder: (BuildContext context, state) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan.shade500, Colors.indigo.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TaskInputField(
                            title: 'Title',
                            hint: 'Enter task title',
                            titleController: _titleController,
                            focusNode: _focusNode,
                          ),

                          const SizedBox(height: 20),

                          // Description Label
                          TaskInputField(
                            title: 'Description',
                            hint: 'Enter task description',
                            titleController: _descriptionController,
                            maxLines: 4,
                          ),

                          const SizedBox(height: 30),

                          // Create Button
                          Center(
                            child:
                                (state is TaskLoading)
                                    ? const Loader()
                                    : ElevatedButton(
                                      onPressed:
                                          taskData == null
                                              ? _createTask
                                              : _updateTask,

                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 50,
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        backgroundColor: Colors.indigo.shade400,
                                        elevation: 5,
                                      ),
                                      child: Text(
                                        taskData != null
                                            ? 'Update Task'
                                            : 'Create Task',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
