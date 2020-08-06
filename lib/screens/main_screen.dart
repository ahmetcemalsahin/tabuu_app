import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tabuu_app/models/team_data.dart';

enum TeamNumber {
  team1,
  team2,
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabuu TR'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MainScreenButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SettingsDialog();
                    });
              },
              title: 'OYNA',
            ),
            MainScreenButton(
              onPressed: () {},
              title: 'YARDIM',
            ),
            MainScreenButton(
              onPressed: () {},
              title: 'HAKKINDA',
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsDialog extends StatefulWidget {
  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TeamData(),
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(0.0),
        backgroundColor: Colors.grey[600],
        children: <Widget>[
          TeamCard(
            selectedTeam: TeamNumber.team1,
          ),
          TeamCard(
            selectedTeam: TeamNumber.team2,
          ),
        ],
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final TeamNumber selectedTeam;

  TeamCard({this.selectedTeam});

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectedTeam == TeamNumber.team1
            ? Provider.of<TeamData>(context, listen: false).changeTeam1Color()
            : Provider.of<TeamData>(context, listen: false).changeTeam2Color();
      },
      child: Consumer<TeamData>(
        builder: (context, teamData, child) {
          return Card(
            margin: EdgeInsets.all(0.0),
            color: selectedTeam == TeamNumber.team1
                ? teamData.team1Color
                : teamData.team2Color,
            elevation: 0.0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.offline_bolt),
                title: TextField(
                  decoration: InputDecoration(
                    hintText: 'Team Name',
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.grey[200],
                  textCapitalization: TextCapitalization.characters,
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                subtitle: Text(
                  'Team starts with the color',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MainScreenButton extends StatelessWidget {
  final Function onPressed;
  final String title;

  MainScreenButton({@required this.onPressed, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: onPressed,
        color: Colors.purple,
        padding: EdgeInsets.all(20.0),
        child: Text(title),
      ),
    );
  }
}
