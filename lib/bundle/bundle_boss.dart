import 'package:basic_engine/widgets/bundle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bundle.dart';

class BundleBoss {
  static Map<String, Bundle> _pool = {};

  static Bundle register(Bundle bundle) {
    Bundle registeredModel = _pool.putIfAbsent(bundle.id, () => bundle);
    print('Id of the registered bundle is $registeredModel');
    return registeredModel;
  }

  static List<Bundle> get bundles {
    List<Bundle> bundles = _pool.entries.map((entry) => entry.value).toList();
    bundles.sort((bundle1, bundle2) => bundle1.sort > bundle2.sort ? 1 : -1);
    return bundles;
  }

  static List<Widget> mapToWidget(BuildContext context) {
    return BundleBoss.bundles
        .map(
          (bundle) => Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: BundleButton.build(
                id: bundle.id,
                text: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(bundle.cnName, style: TextStyle(fontSize: 14.0, fontFamily: 'pinshang')),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 2),
                  child: bundle.icon,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => bundle),
                  );
                }),
          ),
        )
        .toList();
  }
}
