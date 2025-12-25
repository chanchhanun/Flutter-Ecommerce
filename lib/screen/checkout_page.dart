import 'package:flutter/material.dart';
import 'package:grocery_app/constants/AppColor.dart';
import 'package:grocery_app/models/grocery.model.dart';
import 'package:grocery_app/widgets/custom_button_widget.dart';

import 'order_accepted_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final List<Map<String, dynamic>> summaryItems = [
    {"title": "Subtotal", "amount": 430.50},
    {"title": "Shipping", "amount": 0.0, "editable": true},
    {"title": "Estimated Taxes", "amount": 12.00},
    {"title": "Others Fees", "amount": 0.00},
    {"title": "Total", "amount": 442.50, "bold": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 290,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = items[index];
                    return Container(
                      width: double.infinity,
                      height: 140,
                      child: Row(
                        spacing: 10,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: grayLight,
                                ),
                                child: Image.asset(item.imagePath.toString()),
                              ),
                              Positioned(
                                top: -5,
                                right: -5,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: 25,
                                  height: 25,
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 4,
                            children: [
                              Text(
                                item.name.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                item.description.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '\$${item.price}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemCount: items.length,
                ),
              ),
              SizedBox(height: 12),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Discount Code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: primaryDark,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Apply', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
              SizedBox(height: 12),
              ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 8),
                shrinkWrap: true,
                itemCount: summaryItems.length,
                itemBuilder: (context, index) {
                  var summary = summaryItems[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        summary['title'],
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      summary['editable'] == true
                          ? GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Enter shipping Address',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : Text(
                              '\$${summary['amount']}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: summary['bold'] == true
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 18,
                              ),
                            ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        child: CustomButtonWidget(
          title: 'Order Now',
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OrderAcceptedPage()),
            );
          },
        ),
      ),
    );
  }
}
