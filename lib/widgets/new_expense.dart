import 'package:flutter/material.dart';
import 'package:expense_tracker/expense_model.dart';
import 'package:flutter/rendering.dart';

class InputPage extends StatefulWidget {
  const InputPage(this.addexpense, {super.key});
  final void Function(Expense expense) addexpense;
  @override
  State<InputPage> createState() {
    return _InputPage();
  }
}

class _InputPage extends State<InputPage> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedcategory = Category.others;
  Payment _selectedpayment = Payment.cash;

  void datepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1);
    final pickeddate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstdate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickeddate;
    });
  }

  void _submitform() {
    final enteredAmt = double.tryParse(_amountcontroller.text);
    final validAmt = (enteredAmt == null || enteredAmt <= 0);
    if (_titlecontroller.text.trim().isEmpty && validAmt ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            title: Text(
              'Invalid input',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            content: Text('Please make sure that all entered inputs are valid'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    } else {
      widget.addexpense(
        Expense(
          title: _titlecontroller.text,
          amount: enteredAmt!,
          category: _selectedcategory,
          date: _selectedDate!,
          payment: _selectedpayment,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titlecontroller,
                            keyboardType: TextInputType.text,
                            style:
                                Theme.of(context).brightness == Brightness.light
                                ? const TextStyle(color: Colors.black)
                                : const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              label: Text('Title'),
                            ),
                            maxLength: 25,
                            showCursor: true,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            controller: _amountcontroller,
                            cursorHeight: 20,
                            style:
                                Theme.of(context).brightness == Brightness.light
                                ? const TextStyle(color: Colors.black)
                                : const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '₹ ',
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titlecontroller,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).brightness == Brightness.light
                          ? const TextStyle(color: Colors.black)
                          : const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(label: Text('Title')),
                      maxLength: 25,
                      showCursor: true,
                    ),
                  if (width >= 600)
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButton(
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down_sharp),
                                iconSize: 25,
                                elevation: 2,
                                dropdownColor:
                                    Theme.of(context).brightness ==
                                        Brightness.light
                                    ? const Color.fromARGB(255, 169, 144, 231)
                                    : const Color.fromARGB(255, 6, 90, 103),
                                iconEnabledColor:
                                    Theme.of(context).brightness ==
                                        Brightness.light
                                    ? const Color.fromARGB(255, 71, 6, 103)
                                    : const Color.fromARGB(255, 0, 225, 255),
                                borderRadius: BorderRadius.circular(20),
                                value: _selectedcategory,
                                items: Category.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category.name.toUpperCase(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelLarge,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value == null) {
                                    return;
                                  }
                                  setState(() {
                                    _selectedcategory = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              child: DropdownButton(
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down_sharp),
                                iconSize: 25,
                                elevation: 2,
                                dropdownColor:
                                    Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Color.fromARGB(255, 169, 144, 231)
                                    : const Color.fromARGB(255, 6, 90, 103),
                                iconEnabledColor:
                                    Theme.of(context).brightness ==
                                        Brightness.light
                                    ? const Color.fromARGB(255, 71, 6, 103)
                                    : const Color.fromARGB(255, 0, 225, 255),
                                borderRadius: BorderRadius.circular(20),
                                value: _selectedpayment,
                                items: Payment.values.map((paytype) {
                                  return DropdownMenuItem(
                                    value: paytype,
                                    child: Text(
                                      paytype.name.toUpperCase(),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelLarge,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value == null) {
                                    return;
                                  }
                                  setState(() {
                                    _selectedpayment = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _selectedDate == null
                                      ? 'No Date selected'
                                      : formatter.format(_selectedDate!),
                                ),
                                IconButton(
                                  onPressed: datepicker,
                                  icon: Icon(Icons.calendar_month_rounded),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountcontroller,
                            cursorHeight: 20,
                            style:
                                Theme.of(context).brightness == Brightness.light
                                ? const TextStyle(color: Colors.black)
                                : const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '₹ ',
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Date selected'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: datepicker,
                              icon: Icon(Icons.calendar_month_rounded),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (width >= 600)
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: _submitform,
                              child: Text('Add expense'),
                            ),
                          ],
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(15),
                                child: DropdownButton(
                                  isExpanded: true,
                                  icon: Icon(Icons.arrow_drop_down_sharp),
                                  iconSize: 25,
                                  elevation: 2,
                                  dropdownColor:
                                      Theme.of(context).brightness ==
                                          Brightness.light
                                      ? const Color.fromARGB(255, 169, 144, 231)
                                      : const Color.fromARGB(255, 6, 90, 103),
                                  iconEnabledColor:
                                      Theme.of(context).brightness ==
                                          Brightness.light
                                      ? const Color.fromARGB(255, 71, 6, 103)
                                      : const Color.fromARGB(255, 0, 225, 255),
                                  borderRadius: BorderRadius.circular(20),
                                  value: _selectedcategory,
                                  items: Category.values.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(
                                        category.name.toUpperCase(),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelLarge,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value == null) {
                                      return;
                                    }
                                    setState(() {
                                      _selectedcategory = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(15),
                                child: DropdownButton(
                                  isExpanded: true,
                                  icon: Icon(Icons.arrow_drop_down_sharp),
                                  iconSize: 25,
                                  elevation: 2,
                                  dropdownColor:
                                      Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Color.fromARGB(255, 169, 144, 231)
                                      : const Color.fromARGB(255, 6, 90, 103),
                                  iconEnabledColor:
                                      Theme.of(context).brightness ==
                                          Brightness.light
                                      ? const Color.fromARGB(255, 71, 6, 103)
                                      : const Color.fromARGB(255, 0, 225, 255),
                                  borderRadius: BorderRadius.circular(20),
                                  value: _selectedpayment,
                                  items: Payment.values.map((paytype) {
                                    return DropdownMenuItem(
                                      value: paytype,
                                      child: Text(
                                        paytype.name.toUpperCase(),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelLarge,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value == null) {
                                      return;
                                    }
                                    setState(() {
                                      _selectedpayment = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: _submitform,
                              child: Text('Add expense'),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
