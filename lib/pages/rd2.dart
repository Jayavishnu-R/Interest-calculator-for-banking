import 'package:flutter/material.dart';
import 'dart:math';

class RDFORM extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RDFormState();
  }
}

class _RDFormState extends State<RDFORM> {
  var _formKey = GlobalKey<FormState>();

  var _currencies = ["choose", 'SBI', 'Canara', 'KVB'];

  final double _minimumPadding = 5.0;

  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    // TextStyle textStyle = Theme.of(context).textTheme.headlineSmall;

    return Scaffold(
//			resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Recursive Deposit'),
      ),

      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                // getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      // style: textStyle,
                      controller: principalController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter principal amount';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Principal',
                          hintText: 'Enter Principal e.g. 12000',
                          // labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 232, 8, 8),
                              fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      enabled: false,
                      keyboardType: TextInputType.none,
                      // style: textStyle,
                      controller: roiController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter rate of interest';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Rate of Interest',
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: 'In percent',
                          // labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 232, 8, 8),
                              fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          // style: textStyle,
                          controller: termController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter time';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Term',
                              hintText: 'Time in years',
                              // labelStyle: textStyle,
                              errorStyle: TextStyle(
                                  color: Color.fromARGB(255, 232, 8, 8),
                                  fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (String? newValueSelected) {
                            roiController.text = "10";
                            // Your code to execute, when a menu item is selected from dropdown
                            if (newValueSelected != null) {
                              _onDropDownItemSelected(newValueSelected);
                            }
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            // color: Theme.of(context).accentColor,
                            // textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Calculate',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  this.displayResult = _calculateTotalReturns();
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            // color: Theme.of(context).primaryColorDark,
                            // textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.displayResult,
                    // style: textStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 6),
                ),
                Padding(
                    padding: EdgeInsets.all(_minimumPadding * 2),
                    child: Text("KVB provides the best interest rate of 10%",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              18.0, // You can adjust the font size as needed
                        )) // style: textStyle,
                    )
              ],
            )),
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
      if (newValueSelected == "SBI") {
        roiController.text = "7";
      } else if (newValueSelected == "Canara") {
        roiController.text = "7.5";
      } else if (newValueSelected == "KVB") {
        roiController.text = "10";
      } else {
        roiController.text = "";
      }
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    String totalAmountPayable =
        (principal * pow((1 + roi / 100), term)).toStringAsFixed(2);

    String result =
        'After $term years, your investment will be worth $totalAmountPayable Rupees';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
