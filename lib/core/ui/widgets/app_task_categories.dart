import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_parllete.dart';

class TaskCategories extends StatefulWidget {
  const TaskCategories({
    super.key,
    required this.categories,
    this.onPressed,
    this.selectedCategories,
    this.isMulti = true,
  });

  final List<String>? selectedCategories;
  final List<String> categories;
  final bool isMulti;
  final void Function(List<String> selectedCategories)? onPressed;

  @override
  State<TaskCategories> createState() => _TaskCategoriesState();
}

class _TaskCategoriesState extends State<TaskCategories> {
  final List<String> _selectedCategories = [];

  @override
  void initState() {
    super.initState();

    if (widget.selectedCategories != null) {
      _selectedCategories.addAll(widget.selectedCategories!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.categories;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: EdgeInsets.only(
              right: index < (categories.length - 1) ? 8.0 : 0.0,
            ),
            child: GestureDetector(
              onTap: widget.onPressed == null
                  ? null
                  : () {
                      setState(() {
                        if (widget.isMulti) {
                          if (_selectedCategories.contains(categories[index])) {
                            _selectedCategories.remove(categories[index]);
                          } else {
                            _selectedCategories.add(categories[index]);
                          }
                        } else {
                          _selectedCategories.clear();
                          _selectedCategories.add(categories[index]);
                        }

                        widget.onPressed!(_selectedCategories);
                      });
                    },
              child: Chip(
                label: Text(
                  categories[index],
                  style: TextStyle(
                    color: _selectedCategories.contains(categories[index])
                        ? AppPallete.backgroundColor
                        : AppPallete.whiteColor,
                  ),
                ),
                side: BorderSide(
                  color: _selectedCategories.contains(categories[index])
                      ? AppPallete.gradient2
                      : AppPallete.borderColor,
                ),
                shadowColor: AppPallete.transparentColor,
                backgroundColor: _selectedCategories.contains(categories[index])
                    ? AppPallete.gradient2
                    : AppPallete.backgroundColor,
              ),
            ),
          ),
        ).toList(),
      ),
    );
  }
}
