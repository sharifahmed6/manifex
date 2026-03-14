import 'dart:io';

void main() async {
  final bnFile = File(r'c:\Users\shari\my_project\manifex\translation_bn.txt');
  final bnMap = await bnFile.readAsString();

  final translationFile = File(
    r'c:\Users\shari\my_project\manifex\lib\App\Translation.dart',
  );
  var content = await translationFile.readAsString();

  content = content.replaceFirst(
    '    },\n  };\n}',
    '    },\n' + bnMap + '\n  };\n}',
  );

  await translationFile.writeAsString(content);
  print('Translation updated successfully!');
}
