// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

/// AutoGenerateBy Packagex
class PackagexProjectChromeMulti {
/// AutoGenerateBy Packagex
  static bool isSame({
    required String data
  }) {
    return [default_data_to_string, json.encode(default_data)].contains(data);
  }
/// AutoGenerateBy Packagex
    static String get default_data_to_string {
      return (JsonEncoder.withIndent(" " * 2).convert(default_data));
    }
/// AutoGenerateBy Packagex
    static Map get default_data {
return {
  "name": "chrome_multi",
  "description": "A sample command-line application.",
  "version": "0.0.0",
  "executables": {
    "chrome_multi": "chrome_multi"
  },
  "publish_to": "none",
  "funding": [
    "https://github.com/sponsors/azkadev",
    "https://github.com/sponsors/generalfoss"
  ],
  "homepage": "https://youtube.com/@azkadev",
  "repository": "https://github.com/azkadev/general_framework",
  "issue_tracker": "https://t.me/DEVELOPER_GLOBAL_PUBLIC",
  "documentation": "https://youtube.com/@azkadev"
};
    }

}