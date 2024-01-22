bool isCollision(player, block) {
  final hitBox = player.hitBox;
  final playerX = player.position.x -
      player.width * (_isFliped(player) ? 1 : 0) +
      hitBox.offsetX;
  final playerY = player.position.y +
      player.height * (block.isPlatform ? 1 : 0) +
      hitBox.offsetY;
  final playerWidth = hitBox.width;
  final playerHeight = hitBox.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;
  return (playerY < blockY + blockHeight &&
      playerY + playerHeight > blockY &&
      playerX < blockX + blockWidth &&
      playerX + playerWidth > blockX);
}

bool _isFliped(player) {
  return (player.scale.x < 0);
}
