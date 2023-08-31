import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishiz/app_theme.dart';
import 'package:wishiz/l10n.dart';
import 'package:wishiz/provider/items.dart';
import 'package:wishiz/provider/search_text_field.dart';
import 'package:wishiz/widget/app_name.dart';
import 'package:wishiz/widget/item_card.dart';
import 'package:wishiz/widget/widget_utils.dart';

class HomePage extends ConsumerWidget with WidgetUtils {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsProvider);

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const AppName(
              fontSize: 30,
            ),
          ),
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: SearchField(),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 2,
                      ),
                      child: ItemCard(item: item),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchField extends ConsumerWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTextController =
        TextEditingController(text: ref.read(searchTextFieldProvider));

    searchTextController.addListener(() {
      ref
          .read(searchTextFieldProvider.notifier)
          .setValue(searchTextController.text);
    });

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkViolet,
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        controller: searchTextController,
        style: const TextStyle(color: Colors.white),
        cursorColor: AppTheme.lightViolet,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: context.t.search,
          hintStyle: const TextStyle(color: Colors.white),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              searchTextController.clear();
              ref
                  .read(searchTextFieldProvider.notifier)
                  .setValue(''); // also clear the state
            },
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}
