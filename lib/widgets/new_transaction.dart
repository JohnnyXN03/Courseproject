import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titlecontroller = TextEditingController();

  final _amountcontroller = TextEditingController();
  DateTime _selectDate;
  void _submitdata() {
    if(_amountcontroller.toString().isEmpty){
      return;
    } 
    final enteredTitle = _titlecontroller.text;
    final enteredAmount = double.parse(_amountcontroller.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
      
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titlecontroller,
              onSubmitted: (_) => _submitdata,

              // onChanged: (valu){
              // titleinput = valu;
              //  },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitdata,
              //onChanged: (valu){
              // amountinput = valu;
              //},
            ),
            Row(
              children: <Widget>[
                Text(
                  _selectDate == null
                      ? 'No date choosen'
                      : 'Picked Date :${DateFormat.yMd().format(_selectDate)}',
                ),
                FlatButton(
                  textColor: Colors.red,
                  child: Text('Choose date'),
                  onPressed: _presentDatePicker,
                ),
              ],
            ),
            RaisedButton(
                child: Text('Add Transaction'),
                color: Colors.amberAccent,
                onPressed: _submitdata),
          ],
        ),
      ),
    );
  }
}
