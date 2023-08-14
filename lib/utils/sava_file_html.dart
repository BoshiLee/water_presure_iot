import 'dart:html' as html;

void webDownloadFile(dynamic fileEncode, String fileName) {
  final blob = html.Blob([fileEncode]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final _ = html.AnchorElement(href: url)
    ..setAttribute("download", fileName)
    ..click();

  html.Url.revokeObjectUrl(url);
}
