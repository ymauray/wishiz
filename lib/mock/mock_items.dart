import 'package:wishiz/model/item.dart';

final mockItems = List<Item>.generate(
  10,
  (index) => Item(
    id: index.toString(),
    name: 'Product $index',
    imageUrl: 'https://picsum.photos/200?i=$index',
    price: (index + 1) * 10.0,
    description:
        index.isEven ? 'This is a description for Product $index.' : null,
    link: index % 3 == 0 ? 'https://example.com/product$index' : null,
  ),
);
