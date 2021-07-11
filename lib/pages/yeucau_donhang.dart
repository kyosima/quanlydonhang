import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class YeuCau extends StatefulWidget {
  final int id;

  const YeuCau({Key? key, required this.id}) : super(key: key);

  @override
  _YeuCauState createState() => _YeuCauState();
}

class _YeuCauState extends State<YeuCau> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url:
          "https://quantri.mevivu.com/admin/api/yeucaudonhang.php?id=${widget.id}",
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Yêu cầu đơn hàng ${widget.id}'),
      ),
    );
  }
}
