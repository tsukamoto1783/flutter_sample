import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickerSample extends StatefulWidget {
  const PickerSample({Key? key}) : super(key: key);
  final String title = 'test';

  @override
  State<PickerSample> createState() => _PickerSampleState();
}

class _PickerSampleState extends State<PickerSample> {
  String _selectedItem = 'none';
  final List<String> _items = [
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
    'item6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _showModalPicker(context);
              },
              child: const Text('Show Picker'),
            ),
            Text(_selectedItem)
          ],
        ),
      ),
    );
  }

  void _showModalPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 40,
              children: _items.map(_pickerItem).toList(),
              onSelectedItemChanged: _onSelectedItemChanged,
            ),
          ),
        );
      },
    );
  }

  Widget _pickerItem(String str) {
    return Text(
      str,
      style: const TextStyle(fontSize: 32),
    );
  }

  void _onSelectedItemChanged(int index) {
    setState(() {
      _selectedItem = _items[index];
    });
  }
}
