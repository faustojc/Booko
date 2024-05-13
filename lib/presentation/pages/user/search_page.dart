import 'package:booko/resources/colors/theme_colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: ThemeColor.surfaceVariant),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "movies_search_bar",
                child: Material(
                  type: MaterialType.transparency,
                  child: TextField(
                    autofocus: true,
                    onSubmitted: (query) {},
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white),
                      hintText: "Search movies",
                      hintStyle: const TextStyle(color: ThemeColor.surfaceVariant),
                      prefixIcon: const Icon(Icons.search, color: ThemeColor.surfaceVariant),
                      filled: true,
                      fillColor: ThemeColor.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
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
