import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_dropdown_menu.dart';
import '../widgets/empty_search_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(coinCount: 15),
      backgroundColor: const Color(0xFFF7EDE2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //==== BARRA DE PESQUISA
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                suffixIcon: Icon(Icons.search, color: Color(0xFF9BC1BC)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Color(0xFF9BC1BC), width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Color(0xFF9BC1BC), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Color(0xFF9BC1BC), width: 2),
                ),
              ),
            ),
             SizedBox(height: 25),

             CustomDropdownMenu(),

             Expanded(child: EmptySearchState()),
          ],
        ),
      ),
    );
  }
}
