class Room {
  final String roomid;
  final String uid1, uid2;
  final bool isWaiting;
  final int score1, score2;

  Room({
    required this.roomid,
    required this.uid1,
    required this.uid2,
    required this.isWaiting,
    required this.score1,
    required this.score2,
  });
}
