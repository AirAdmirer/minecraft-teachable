import 'dart:math';

import 'package:minecraft/components/block_component.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/items.dart';

class BirchLeafBlock extends BlockComponent {
  BirchLeafBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.birchLeaf);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    if (Random().nextBool()) {
      itemDropped = Items.apple;
    }
  }
}
