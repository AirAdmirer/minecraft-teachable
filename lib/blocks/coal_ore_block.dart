import 'package:minecraft/components/block_component.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/items.dart';

class CoalOreBlock extends BlockComponent {
  CoalOreBlock({required super.blockIndex, required super.chunkIndex})
      : super(block: Blocks.coalOre);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    itemDropped = Items.coal;
  }
}
