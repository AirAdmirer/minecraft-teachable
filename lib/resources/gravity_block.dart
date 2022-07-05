import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:minecraft/components/block_component.dart';
import 'package:minecraft/resources/blocks.dart';
import 'package:minecraft/utils/game_methods.dart';

class GravityBlock extends BlockComponent with CollisionCallbacks {
  GravityBlock(
      {required super.block,
      required super.blockIndex,
      required super.chunkIndex});

  bool isCollidingBottom = false;

  int blocksPerSecondSpeed = 3;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is BlockComponent) {
      if ((intersectionPoints.first.x - intersectionPoints.last.x).abs() >
          size.x * 0.4) {
        isCollidingBottom = true;

        GameMethods.instance.replaceBlockAtWorldChunks(null, blockIndex);

        blockIndex = GameMethods.instance.getIndexPositionFromPixels(position);

        GameMethods.instance.replaceBlockAtWorldChunks(block, blockIndex);
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (GameMethods.instance
            .getBlockAtDirection(blockIndex, Direction.bottom) ==
        null) {
      position.y +=
          (blocksPerSecondSpeed * GameMethods.instance.blockSize.x) * dt;
    }

    isCollidingBottom = false;
  }
}
