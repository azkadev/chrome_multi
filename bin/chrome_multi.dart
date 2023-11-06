// ignore_for_file: empty_catches, non_constant_identifier_names

import 'dart:convert';
import 'dart:io'; 
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

import 'package:galaxeus_lib/galaxeus_lib.dart';

Future<Process> googleChrome({
  required Directory directory,
}) async {
  Process shell = await Process.start("google-chrome", [
    "--user-data-dir=${directory.path}",
  ], environment: {
    "FILES": directory.path,
  });
  shell.stdout.listen((event) {
    stdout.add(event);
  });
  shell.stderr.listen((event) {
    stdout.add(event);
  });
  stdin.listen((event) {
    shell.stdin.add(event);
  });
  return shell;
}

String ask({required String question}) {
  while (true) {
    stdout.write(question);
    String? res = stdin.readLineSync();
    if (res != null && res.isNotEmpty) {
      return res;
    }
  }
}

void main(List<String> arg) async {
  Logger logger = Logger(
    level: Level.verbose,
  );
  Args args = Args(arg);
  Directory directory_root = Directory(p.join(Directory.current.path, "chrome_multi_db"));
  if (!directory_root.existsSync()) {
    await directory_root.create(recursive: true);
  }
  String? name = () {
    String parse_name = args["-name"] ?? "";

    if (parse_name.isNotEmpty) {
      return parse_name;
    }
    List<String> folders = [
      "Create New",
      ...directory_root.listSync().map((e) => p.basename(e.path)).toList(),
    ];
    String create_new = logger.chooseOne("Silahkan Pilih Folder", choices: folders);

    if (create_new == folders.first) {
      return logger.prompt("Name Folder : ");
    }

    return create_new;
    // name ??= ask(question: "NAME:");
  }();
  Directory directory = Directory(p.join(directory_root.path, name));
  if (!directory.existsSync()) {
    try {
      File config_chrome = File(p.join(directory.path, "Local State"));
      await config_chrome.create(recursive: true);
      await config_chrome.writeAsString(json.encode({
        "background_mode": {
          "enabled": false,
        }
      }));
    } catch (e) {}
  }
  await googleChrome(
    directory: directory,
  );
  File config_chrome = File(p.join(directory.path, "Local State"));
  while (true) {
    try {
      await Future.delayed(Duration(milliseconds: 2000));
      if (await config_chrome.exists()) {
        Map jsonData = json.decode(await config_chrome.readAsString());
        bool is_update = false;
        if (jsonData["background_mode"] is Map == false) {
          is_update = true;
          jsonData["background_mode"] = {
            "enabled": false,
          };
        }
        if (jsonData["background_mode"]["enabled"] != false) {
          is_update = true;
          jsonData["background_mode"]["enabled"] = false;
        }
        if (is_update) {
          await config_chrome.writeAsString(json.encode(jsonData));
        }
        return print("succes set background to false");
      }
    } catch (e) {}
  }
}
