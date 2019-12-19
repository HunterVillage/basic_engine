import 'package:basic_engine/app.dart';
import 'package:basic_engine/bundle/piano.dart';
import 'package:basic_engine/model/user_info.dart';
import 'package:flutter/material.dart';

/// @author wujianchuan
/// @date 2019/12/19 21:56
class PianoBoss {
  static Map<String, Map<String, Piano>> _pool = {};
  static Map<String, Piano> allPianos = {};

  static Piano register(String groupName, Piano piano) {
    allPianos.putIfAbsent(piano.id, () => piano);
    Map<String, Piano> pianoMap = _pool.putIfAbsent(groupName, () => {});
    return pianoMap.putIfAbsent(piano.id, () => piano);
  }

  static Map<String, List<Piano>> get group {
    UserInfo _userInfo = App.getInstance().userInfo;
    Map<String, List<Piano>> groupingPianos = {};
    if (_userInfo != null) {
      List pianoIds = _userInfo.bundleIds;
      _pool.entries.forEach((entry) {
        List<Piano> pianos = entry.value.values.where((piano) => inProduction ? pianoIds.contains(piano.id) : true).toList();
        pianos.sort((piano1, piano2) => piano1.sort > piano2.sort ? 1 : -1);
        if (pianos.length > 0) groupingPianos.putIfAbsent(entry.key, () => pianos);
      });
    }
    return groupingPianos;
  }

  static List<Widget> groupingMenus(BuildContext context) {
    return PianoBoss.group.entries.map((entry) {
      List<Piano> pianos = entry.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPianoWidget(pianos, context),
      );
    }).toList();
  }

  static List<Widget> _buildPianoWidget(List<Piano> pianos, BuildContext context) {
    List<Widget> pianoButtons = pianos.map((piano) {
      return Container(
        child: GestureDetector(
          child: ListTile(
            leading: piano.leading,
            title: Text(piano.cnName, style: TextStyle(color: Colors.black54)),
            trailing: Icon(Icons.chevron_right),
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => piano)),
        ),
        color: Colors.white,
      );
    }).toList();
    pianoButtons.add(Container(height: 20));
    return pianoButtons;
  }
}
