import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Home Page', () {
    final homeTitle = find.byValueKey('home_title');
    final addTaskButton = find.byValueKey('add_task');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Today in Title', () async {
      var emptyTaskMessage = find.byValueKey('messageInCenter');
      expect(await driver.getText(homeTitle), "Today");
      expect(await driver.getText(emptyTaskMessage), "No Task Added");
    });

    /* test('Add Task Button Clicked', () async {
      await driver.tap(addTaskButton);
      var addTaskTitle = find.byValueKey('add_task_title');
      expect(await driver.getText(addTaskTitle), "Add Task");
    });*/

    test('Enter Task Details and verify on Task page screen', () async {
      await driver.tap(addTaskButton);

      var addTaskTitle = find.byValueKey('add_task_title');
      expect(await driver.getText(addTaskTitle), "Add Task");

      var addTitle = find.byValueKey('addTitle');
      await driver.tap(addTitle);
      await driver.enterText("First Task");

      var addTask = find.byValueKey('addTask');
      await driver.tap(addTask);

      var taskTitle = find.byValueKey('taskTitle');
      var taskProjectName = find.byValueKey('taskProjectName');
     // var taskLabel = find.byValueKey('taskLabel');

      expect(await driver.getText(taskTitle), "First Task");
      expect(await driver.getText(taskProjectName), "Inbox");
     // expect(await driver.getText(taskLabel), "");
    });
  });
}