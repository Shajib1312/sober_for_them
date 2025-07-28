// lib/src/presentation/screens/calendar_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/task_model.dart';

import '../../utils/storage.dart';
import '../controllers/auth_controller.dart';

class CalendarScreen extends StatelessWidget {
  final List<String> days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
  final List<int> dates = List.generate(30, (i) => i + 1);
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final tasks = Storage.getTasks();

    return Scaffold(
      appBar: AppBar(
        title: Text("See Your Task"),
        actions: [
          IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
          Text("June 2020 >", style: TextStyle(fontSize: 16)),
          IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Days of Week
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: days
                  .map(
                    (day) => Text(
                      day,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                  .toList(),
            ),
          ),

          // Calendar Grid
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: dates.map((date) {
              final hasTask = tasks.any(
                (task) =>
                    task.date.day == date &&
                    task.date.month == 6 &&
                    task.date.year == 2020,
              );
              bool isToday = date == 14;
              return Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hasTask
                      ? Colors.blue.withOpacity(0.2)
                      : (isToday ? Colors.blue : Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "$date",
                  style: TextStyle(
                    color: isToday ? Colors.white : Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),

          Spacer(),

          // Tasks for today
          if (tasks.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Tasks",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...tasks.map(
                    (task) => ListTile(
                      title: Text(task.title),
                      trailing: Checkbox(
                        value: task.isCompleted,
                        onChanged: (bool? value) {
                          final updatedTask = TaskModel(
                            id: task.id,
                            title: task.title,
                            date: task.date,
                            isCompleted: value ?? false,
                            description: task.description,
                          );
                          Storage.updateTask(updatedTask);
                          Get.find<AuthController>().update();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Time Selector
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Time"),
                Text("11:38"),
                ElevatedButton(onPressed: () {}, child: Text("AM")),
                ElevatedButton(onPressed: () {}, child: Text("PM")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
