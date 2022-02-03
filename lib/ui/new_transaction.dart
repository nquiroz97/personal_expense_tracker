import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction({Key? key, required this.addTransaction}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _price = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _title.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Add expense",
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _title,
            onSubmitted: (_) => _onAddTransactionCall(),
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            controller: _price,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _onAddTransactionCall(),
            decoration: const InputDecoration(
              label: Text('Price'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'no date chosen'
                      : DateFormat.yMd().format(_selectedDate!)),
                ),
                TextButton(
                    onPressed: () => _showDatePicker(),
                    child: const Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _onAddTransactionCall,
                child: const Text('Add'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onAddTransactionCall() {
    var title = _title.text.trim();
    var amount = double.tryParse(_price.text.trim());

    if (title.isEmpty || amount == null || amount <= 0) {
      return;
    }
    widget.addTransaction(title, amount, _selectedDate ?? DateTime.now());

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _selectedDate = date;
      });
    });
  }
}
