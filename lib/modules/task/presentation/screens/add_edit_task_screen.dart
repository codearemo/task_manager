import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/theme/app_parllete.dart';
import 'package:task_manager/core/ui/widgets/app_gradient_button.dart';
import 'package:task_manager/core/ui/widgets/app_input.dart';
import 'package:task_manager/core/ui/widgets/app_task_categories.dart';
import 'package:task_manager/core/ui/widgets/feedback/app_snackbar.dart';
import 'package:task_manager/core/utils/form_validators.dart';
import 'package:task_manager/modules/auth/presentation/bloc/auth_module_bloc.dart';
import 'package:task_manager/modules/task/domain/entities/task_entity.dart';
import 'package:task_manager/modules/task/domain/usecases/add_task_usecase.dart';
import 'package:task_manager/modules/task/presentation/bloc/task_module_bloc.dart';
import 'package:task_manager/modules/task/presentation/widgets/post_editor.dart';

class AddEditPostScreenArgs {
  final TaskEnitity? task;

  AddEditPostScreenArgs({
    this.task,
  });
}

class AddEditPostScreen extends StatefulWidget {
  final AddEditPostScreenArgs args;

  const AddEditPostScreen({
    super.key,
    required this.args,
  });

  @override
  State<AddEditPostScreen> createState() => _AddEditPostScreenState();
}

class _AddEditPostScreenState extends State<AddEditPostScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isTaskCompleted = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String>? _selectedCategories;

  final List<String> categories = [
    'Work',
    'School',
    'Gym',
    'Family',
    'Recreation',
    'Hobby',
  ];

  void createTask() {
    final taskModuleBloc = context.read<TaskModuleBloc>();
    final authModuleBloc = context.read<AuthModuleBloc>();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_selectedCategories == null || (_selectedCategories ?? []).isEmpty) {
        return AppSnackBars.primarySnackbar(
          context: context,
          message: 'Please select on category.',
          backgroundColor: AppPallete.errorColor,
        );
      }

      if (widget.args.task == null) {
        taskModuleBloc.add(AddTaskEvent(
            params: TaskOpParams(
          task: TaskEnitity(
            id: widget.args.task?.id,
            authorId: authModuleBloc.currentUser?.uid,
            authorEmail: authModuleBloc.currentUser?.email,
            title: titleController.text,
            description: descriptionController.text,
            selectedCateories: _selectedCategories ?? [],
            isCompleted: isTaskCompleted,
          ),
        )));
      } else {
        taskModuleBloc.add(UpdateTaskEvent(
            params: TaskOpParams(
          task: TaskEnitity(
            id: widget.args.task?.id,
            authorEmail: authModuleBloc.currentUser?.email,
            authorId: authModuleBloc.currentUser?.uid,
            title: titleController.text,
            description: descriptionController.text,
            selectedCateories: _selectedCategories ?? [],
            isCompleted: isTaskCompleted,
          ),
        )));
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  initializeTask() {
    if (widget.args.task != null) {
      final task = widget.args.task;

      titleController.text = '${task?.title}';
      descriptionController.text = '${task?.description}';
      _selectedCategories = task?.selectedCateories;
      isTaskCompleted = task?.isCompleted ?? false;
    }

  }

  @override
  void initState() {
    super.initState();

    initializeTask();
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.args.task;

    return BlocConsumer<TaskModuleBloc, TaskModuleState>(
      listener: (context, state) {
        if (state is AddTaskError) {
          return AppSnackBars.primarySnackbar(
            context: context,
            message: state.message,
            backgroundColor: AppPallete.errorColor,
          );
        } else if (state is UpdateTaskError) {
          return AppSnackBars.primarySnackbar(
            context: context,
            message: state.message,
            backgroundColor: AppPallete.errorColor,
          );
        } else if (state is AddTaskSuccess || state is UpdateTaskSuccess) {
          AppSnackBars.primarySnackbar(
            context: context,
            message:
                'Task ${task?.id == null ? 'added' : 'updated'} successfully.',
          );
          context.pop<TaskEnitity?>(task);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              task?.id == null ? 'Add Task' : 'Update Task',
            ),
          ),
          persistentFooterButtons: [
            AppGradientButton(
              loading: state is AddTaskLoading || state is UpdateTaskLoading,
              onPressed: createTask,
              child: const Text('Done',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )),
            )
          ],
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Categories',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 10),
                    TaskCategories(
                      categories: categories,
                      isMulti: false,
                      selectedCategories: _selectedCategories,
                      onPressed: (selectedTags) {
                        _selectedCategories = selectedTags;
                      },
                    ),
                    const SizedBox(height: 30),
                    AppInput(
                      hintText: 'Title',
                      controller: titleController,
                      validator: (value) {
                        return AppFormValidator.validateField(value, 'Title');
                      },
                    ),
                    const SizedBox(height: 20),
                    AppPostEditor(
                      hintText: 'Description',
                      controller: descriptionController,
                      validator: (value) {
                        return AppFormValidator.validateField(
                            value, 'Description');
                      },
                    ),
                    const SizedBox(height: 20),
                    CheckboxListTile(
                      title: const Text('Task Completed'),
                      value: isTaskCompleted,
                      onChanged: (value) {
                        setState(() {
                          isTaskCompleted = value ?? false;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
