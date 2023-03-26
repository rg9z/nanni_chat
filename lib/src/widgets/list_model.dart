import 'package:flutter/material.dart';

typedef RemovedItemBuilder = Widget Function(
    int item, BuildContext context, Animation<double> animation);

class ListMessage<E> {
  ListMessage({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<SliverAnimatedListState> listKey;
  final RemovedItemBuilder removedItemBuilder;
  final List<E> _items;

  SliverAnimatedListState get _animatedList => listKey.currentState!;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(
      index,
    );
  }

  void insertAll(int index, List<E> items) {
    _items.insertAll(index, items);

    for (var i = 0; i < items.length; i++) {
      _animatedList.insertItem(index + i,
          duration: const Duration(milliseconds: 0));
    }
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            removedItemBuilder(index, context, animation),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
