import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/bundle_button.dart';
import 'bundle.dart';

class BundleBoss {
  static Map<String, Bundle> _pool = {};

  static Bundle register(Bundle model) {
    Bundle registeredModel = _pool.putIfAbsent(model.getId(), () => model);
    print('id of the registered model is $registeredModel');
    return registeredModel;
  }

  static List<Bundle> get bundles {
    List<Bundle> bundles = _pool.entries.map((entry) => entry.value).toList();
    bundles.sort((bundle1, bundle2) => bundle1.getSort() > bundle2.getSort() ? 1 : -1);
    return bundles;
  }

  static List<Widget> mapToWidget(BuildContext context) {
    return BundleBoss.bundles
        .map(
          (bundle) => Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: BundleButton.build(
                text: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(bundle.getCnName(), style: TextStyle(fontSize: 12.0)),
                ),
                icon: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 2),
                  child: bundle.getIcon(),
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
