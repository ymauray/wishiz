import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wishiz/app_theme.dart';
import 'package:wishiz/l10n.dart';

class ItemForm extends ConsumerStatefulWidget {
  const ItemForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemFormState();
}

class _ItemFormState extends ConsumerState<ItemForm> {
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Material(
            shape: CircleBorder(),
            elevation: 5,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppTheme.darkViolet,
              child: Icon(
                Icons.add_a_photo,
                size: 50,
                color: Colors.white,
              ),
              //backgroundImage: NetworkImage(item.imageUrl),
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: context.t.name,
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: context.t.price,
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: context.t.link,
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    AppTheme.darkViolet,
                  ),
                  foregroundColor: MaterialStatePropertyAll<Color>(
                    Colors.white,
                  ),
                ),
                child: Text(context.t.cancel),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(context.t.submit),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
