import 'package:flutter/material.dart';
import 'package:wishiz/app_theme.dart';
import 'package:wishiz/model/item.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    required this.item,
    super.key,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.lightViolet,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.red,
          backgroundImage: NetworkImage(item.imageUrl),
        ),
        title: Text(item.name),
        subtitle: Text(item.description ?? ''),
        trailing: item.link != null
            ? IconButton(
                icon: const Icon(Icons.link),
                onPressed: () {
                  // Implement logic to open link, e.g., using url_launcher package.
                },
              )
            : null,
      ),
    );
  }
}
