import 'package:minecraft/components/block_component.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/items.dart';

class IronOreBlock extends BlockComponent {
  IronOreBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.ironOre);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    itemDropped = Items.ironIngot;
  }
}
