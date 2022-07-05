import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/resources/structures.dart';

Structure cactus = Structure(structure: [
  [Blocks.cactus],
  [Blocks.cactus]
], maxOccurences: 3, maxWidth: 1);

Structure deadBush = Structure(structure: [
  [Blocks.deadBush]
], maxOccurences: 3, maxWidth: 1);

Structure redFlower = Structure.getPlantStructureForBlock(Blocks.redFlower);
Structure purpleFlower =
    Structure.getPlantStructureForBlock(Blocks.purpleFlower);
Structure drippingWhiteFlower =
    Structure.getPlantStructureForBlock(Blocks.drippingWhiteFlower);
Structure yellowFlower =
    Structure.getPlantStructureForBlock(Blocks.yellowFlower);
Structure whiteFlower = Structure.getPlantStructureForBlock(Blocks.whiteFlower);
