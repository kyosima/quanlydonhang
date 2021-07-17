import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LichSuThanhToan extends StatefulWidget {
  final int id;

  const LichSuThanhToan({Key? key, required this.id}) : super(key: key);
  @override
  _LichSuThanhToanState createState() => _LichSuThanhToanState();
}

class _LichSuThanhToanState extends State<LichSuThanhToan> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url:
          "https://quantri.mevivu.com/admin/api/lichsuthanhtoan.php?id=${widget.id}",
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Lịch sử thanh toán ${widget.id}'),
      ),
    );
  }
}
