import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function logic;

  NewTransaction(this.logic);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selectDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = titleController.text;
    final amountText = double.parse(amountController.text);

    if (enteredTitle.isEmpty || amountText <= 0 || _selectDate == null) {
      return;
    }
    widget.logic(
      enteredTitle,
      amountText,
      _selectDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleController,
              onSubmitted: (_) => submitData(),
//                    onChanged: (value) {
//                      titleInput = value;
//                    },
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
//                    onChanged: (value) {
//                      amountInput = value;
//                    },
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectDate == null
                          ? 'No Date choosen'
                          : DateFormat.yMMMd().format(_selectDate),
                    ),
                  ),
                  CupertinoButton(
                    child: Text(
                      'Chose Date',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      _presentDatePicker();
                    },
                  ),
                ],
              ),
            ),
            CupertinoButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.lightBlueAccent),
              ),
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
