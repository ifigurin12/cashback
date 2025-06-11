import 'package:flutter/material.dart';

class FamilyPage extends StatelessWidget {
  final bool isFamilyLeader;

  const FamilyPage({super.key, required this.isFamilyLeader});

  @override
  Widget build(BuildContext context) {
    final familyName = 'Скворцовы';
    final members = ['Elena', 'Anna', 'Alex'];
    final invitations = ['Tom'];

    return Scaffold(
      appBar: AppBar(title: Text('Семья')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.family_restroom, color: Colors.white),
                  SizedBox(width: 12),
                  Text(
                    familyName,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Участники',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...members.map((name) => Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.white),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(name,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      if (isFamilyLeader)
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.redAccent),
                          onPressed: () {
                            // логика удаления участника
                          },
                        ),
                    ],
                  ),
                )),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Приглашения',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.blueAccent),
                  onPressed: () {
                    // логика повторной отправки приглашения
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...invitations.map((name) => Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.mail_outline, color: Colors.white),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(name,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                      if (isFamilyLeader) ...[
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.redAccent),
                          onPressed: () {
                            // логика отмены приглашения
                          },
                        ),
                      ],
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
