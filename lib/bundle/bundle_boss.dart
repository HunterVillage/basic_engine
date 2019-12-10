import 'package:basic_engine/widgets/bundle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'bundle.dart';

class BundleBoss {
  static Map<String, Map<String, Bundle>> _pool = {};

  static Bundle register(String groupName, Bundle bundle) {
    Map<String, Bundle> bundleMap = _pool.putIfAbsent(groupName, () => {});
    Bundle registeredModel = bundleMap.putIfAbsent(bundle.id, () => bundle);
    print('Id of the registered bundle is $registeredModel');
    return registeredModel;
  }

  static Map<String, List<Bundle>> get group {
    Map<String, List<Bundle>> groupingBundles = {};
    _pool.entries.forEach((entry) {
      List<Bundle> bundles = entry.value.entries.map((entry) => entry.value).toList();
      bundles.sort((bundle1, bundle2) => bundle1.sort > bundle2.sort ? 1 : -1);
      groupingBundles.putIfAbsent(entry.key, () => bundles);
    });
    return groupingBundles;
  }

  static List<Widget> mapToWidget(BuildContext context) {
    return BundleBoss.group.entries.map((entry) {
      List<Bundle> bundles = entry.value;
      String groupName = entry.key;
      return Container(
        margin: EdgeInsets.all(6),
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              child: Text(groupName, style: TextStyle(fontSize: 16.0, fontFamily: 'pinshang')),
            ),
            Divider(
              height: 20,
            ),
            Wrap(
              children: _buildBundleWidget(bundles, context),
            ),
          ],
        ),
      );
    }).toList();
  }

  static List<Widget> _buildBundleWidget(List<Bundle> bundles, BuildContext context) {
    return bundles.map((bundle) {
      double width = MediaQuery.of(context).size.width / 3 - 8;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 3),
        child: BundleButton.build(
            width: width,
            id: bundle.id,
            text: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(bundle.cnName, style: TextStyle(fontSize: 14.0, fontFamily: 'pinshang', color: Colors.black54)),
            ),
            icon: Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 2), child: bundle.icon),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => bundle))),
      );
    }).toList();
  }
}
