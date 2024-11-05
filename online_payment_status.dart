import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PaymentStatus extends StatefulWidget {
  const PaymentStatus({super.key});

  @override
  _PaymentStatusState createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  final TextEditingController accountNoController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  DateTime? selectedFromDate;
  DateTime? selectedToDate;


  Future<void> _selectDate(BuildContext context, TextEditingController controller, bool isFromDate) async {
    final DateTime initialDate = isFromDate
        ? (selectedFromDate ?? DateTime.now())
        : (selectedToDate ?? DateTime.now());

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          selectedFromDate = picked;
          controller.text = DateFormat('yyyy-MM-dd').format(picked);
          // Reset "To Date" if it's earlier than "From Date"
          if (selectedToDate != null && picked.isAfter(selectedToDate!)) {
            toDateController.clear();
            selectedToDate = null;
          }
        } else {
          if (selectedFromDate != null && picked.isBefore(selectedFromDate!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('To Date must be after From Date')),
            );
          } else {
            selectedToDate = picked;
            controller.text = DateFormat('yyyy-MM-dd').format(picked);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Bill & Payment History',
          style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(17, 94, 163, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
            color: Color.fromRGBO(17, 94, 163, 1),),
          onPressed: () {
         
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/layout.svg',
              color: Color.fromRGBO(17, 94, 163, 1),
              width: 30,
              height: 24,
            ),
            onPressed: () {

            },
          ),
        ],
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                'Account No.',
                style: TextStyle(fontSize: 16),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                margin: const EdgeInsets.only(top: 8, bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '91119408000',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),


              const Text(
                'From Date',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: fromDateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Select From Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onTap: () => _selectDate(context, fromDateController, true),
              ),
              const SizedBox(height: 16),


              const Text(
                'To Date',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: toDateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Select To Date',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onTap: () => _selectDate(context, toDateController, false),
              ),
              const SizedBox(height: 25),


              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedFromDate == null || selectedToDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select both dates')),
                        );
                        return;
                      }

                      if (selectedFromDate!.isAfter(selectedToDate!)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('From Date must be before To Date')),
                        );
                        return;
                      }


                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(17, 94, 163, 1),
                      minimumSize: Size(double.infinity, 50),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                     const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text(
                            'Bill No.',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'ALLSU8494',
                            style: TextStyle(fontSize: 14,
                            color: Color.fromRGBO(17, 94, 163, 1),),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),


                     const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text(
                            'Bill Date',
                            style: TextStyle(fontSize: 14
                             ),
                          ),
                          Text(
                            '01-10-2024',
                            style: TextStyle(fontSize: 14,
                              color: Color.fromRGBO(17, 94, 163, 1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                     const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text(
                            'Amount',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'INR 134.0',
                            style: TextStyle(fontSize: 14,
                              color: Color.fromRGBO(17, 94, 163, 1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                     const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text(
                            'Bill Date',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '08-10-2024',
                            style: TextStyle(fontSize: 14,
                              color: Color.fromRGBO(17, 94, 163, 1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text(
                            'Bill Issued Date',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '01-10-2024',
                            style: TextStyle(fontSize: 14,
                              color: Color.fromRGBO(17, 94, 163, 1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),


                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text(
                            'Payment Date',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '11-10-2024',
                            style: TextStyle(fontSize: 14,
                              color: Color.fromRGBO(17, 94, 163, 1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),


                     const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text(
                            'Payment Mode',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Credit Card',
                            style: TextStyle(fontSize: 14,
                              color: Color.fromRGBO(17, 94, 163, 1),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 14),

                      Row(
                        children: [
                          const Text(
                            'Download Bill',
                            style: TextStyle(fontSize: 14),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {

                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              minimumSize: Size(15, 15),
                            ),
                            child: const Text(
                              'PDF',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        ],
                      ),




                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
