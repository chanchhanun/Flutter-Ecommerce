import 'package:flutter/material.dart';
import 'package:grocery_app/constants/AppColor.dart';
import 'package:grocery_app/screen/phone_number_page.dart';
import 'package:grocery_app/widgets/custom_button_widget.dart';

class SelectedLocationPage extends StatefulWidget {
  const SelectedLocationPage({super.key});

  @override
  State<SelectedLocationPage> createState() => _SelectedLocationPageState();
}

class _SelectedLocationPageState extends State<SelectedLocationPage> {
  final imageLocation = 'assets/images/location.png';
  String selectedZone = 'PhnomPenh';
  String selectedArea = 'Cambodia';
  final List<String> lsZones = ['PhnomPenh', 'Kondal', 'BMC', 'Malai'];
  final List<String> lsArea = ['Cambodia', 'Canada', 'USA', 'UK'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 80,
          children: [
            Column(
              children: [
                Center(child: Image.asset(imageLocation, height: 300)),
                Center(
                  child: Text(
                    'Select your location',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Switch on your location to stay in tune with what\'s happening in your area',
                  style: TextStyle(
                    color: gray,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your zone',
                  style: TextStyle(
                    color: grayDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                DropdownButtonFormField(
                  value: selectedZone,
                  items: lsZones
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 12),
                Text(
                  'Your Area',
                  style: TextStyle(
                    color: grayDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                DropdownButtonFormField(
                  value: selectedArea,
                  items: lsArea
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                CustomButtonWidget(
                  title: 'Submit',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhoneNumberPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
