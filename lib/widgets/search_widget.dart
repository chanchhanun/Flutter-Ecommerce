import 'package:flutter/material.dart';
import 'package:grocery_app/screen/search_sort_page.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        readOnly: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchSortPage()),
          );
        },
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
          prefixIcon: Icon(Icons.search),
          hintText: 'Search Store',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
