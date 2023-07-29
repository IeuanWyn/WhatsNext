import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colours.dart';
import '../widget/search_box_custom.dart';
import '../widget/todo_item.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _dateFieldController = TextEditingController();
  final List<Todo> _todoslist = <Todo>[];

  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColour,
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const SearchBoxCustom(),
            Expanded(
              child: _buildListView(),
            ),
          ],
        ),
        /**/
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }

  ListView _buildListView() {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30, bottom: 15),
          child: const Text(
            "All ToDos",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        for (Todo itTodo in _todoslist)
          TodoItem(
            todo: itTodo,
            onTodoChanged: _handleTodoChange,
            dueDate: itTodo.dueDate,
          ),
      ],
    );
  }

  // Other functions
  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new todo item'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your new todo'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text, DateTime.now());
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: Colors.amber[900],
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.amber,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 3)))
          .isNegative,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text('Single Date Picker (With default value)'),
        CalendarDatePicker2(
          config: config,
          value: _singleDatePickerValueWithDefaultValue,
          onValueChanged: (dates) =>
              setState(() => _singleDatePickerValueWithDefaultValue = dates),
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Selection(s):  '),
            SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  void _addTodoItem(String name, DateTime date) {
    setState(() {
      _todoslist.add(Todo(name: name, checked: false, dueDate: date));
    });
    _textFieldController.clear();
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColour,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: tdBlack, size: 30),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.png'),
            ),
          )
        ],
      ),
    );
  }
}
