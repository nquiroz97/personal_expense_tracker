import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction({Key? key, required this.addTransaction}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _price = TextEditingController();

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
          const Text(
            "Add expense",
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _title,
            onSubmitted: (_) => onAddTransactionCall(),
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            controller: _price,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => onAddTransactionCall(),
            decoration: const InputDecoration(
              label: Text('Price'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: onAddTransactionCall,
                child: const Text('Add'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void onAddTransactionCall() {
    var title = _title.text.trim();
    var amount = double.tryParse(_price.text.trim());

    if (title.isEmpty || amount == null || amount <= 0) {
      return;
    }
    widget.addTransaction(title, amount);

    Navigator.of(context).pop();
  }
}
