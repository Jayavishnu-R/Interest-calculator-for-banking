import 'package:flutter/material.dart';
import 'dart:math';

class EMICalculator extends StatefulWidget {
  @override
  _EMICalculatorState createState() => _EMICalculatorState();
}

class _EMICalculatorState extends State<EMICalculator> {
  double principalAmount = 0.0;
  double interestRate = 0.0;
  int loanTerm = 0;
  double emi = 0.0;

  void calculateEMI() {
    if (principalAmount > 0 && interestRate > 0 && loanTerm > 0) {
      double monthlyInterestRate = interestRate / 1200;
      int totalMonths = loanTerm * 12;
      emi = (principalAmount *
              monthlyInterestRate *
              (pow(1 + monthlyInterestRate, totalMonths))) /
          ((pow(1 + monthlyInterestRate, totalMonths)) - 1);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EMI Calculator'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Principal Amount',
                ),
                onChanged: (value) {
                  setState(() {
                    principalAmount = double.parse(value);
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Interest Rate (%)',
                ),
                onChanged: (value) {
                  setState(() {
                    interestRate = double.parse(value);
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Loan Term (years)',
                ),
                onChanged: (value) {
                  setState(() {
                    loanTerm = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  calculateEMI();
                },
                child: Text('Calculate EMI'),
              ),
              SizedBox(height: 20.0),
              Text(
                'EMI: \$${emi.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
