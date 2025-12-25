import 'package:flutter/material.dart';
import 'package:grocery_app/constants/AppColor.dart';
import 'package:grocery_app/widgets/checkbox_widget.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final List<String> categoryName = [
    'Eggs',
    'Noodle & Pasta',
    'Chip & Crisps',
    'Fast Food',
  ];

  final List<String> brandName = [
    'Individual Collection',
    'Cocola',
    'Ifad ',
    'Kazi Farmas ',
  ];

  late List<bool> selectedCategory;
  late List<bool> selectedBrand;
  @override
  void initState() {
    super.initState();
    selectedCategory = List.generate(categoryName.length, (index) => false);
    selectedBrand = List.generate(brandName.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        title: Text(
          'Filters',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: grayLight.withValues(alpha: .3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: categoryName.length,
              itemBuilder: (context, index) {
                var item = categoryName[index];
                return CheckboxWidget(
                  title: item,
                  isChecked: selectedCategory[index],
                  onChanged: (value) {
                    setState(() {
                      selectedCategory[index] = value!;
                    });
                  },
                );
              },
            ),
            Text(
              'Brand',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: brandName.length,
              itemBuilder: (context, index) {
                var item = brandName[index];
                return CheckboxWidget(
                  title: item,
                  isChecked: selectedBrand[index],
                  onChanged: (value) {
                    setState(() {
                      selectedBrand[index] = value!;
                    });
                  },
                );
              },
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(12.0),
                  backgroundColor: primary,
                  foregroundColor: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Apply Filter',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
