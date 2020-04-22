import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PDFview extends StatefulWidget {
  String link;

  PDFview({this.link});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PDFviewState();
  }
}

class PDFviewState extends State<PDFview> {
  bool _isLoading;

  // Load from URL
  PDFDocument doc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    loadPdf();
  }

  loadPdf() async {
    doc = await PDFDocument.fromURL(widget.link);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                margin: EdgeInsets.only(top: 20.0),
                child: SafeArea(
                  bottom: false,
                  child: PDFViewer(
                    showNavigation: true,
                    showIndicator: false,
                    document: doc,
                    showPicker: false,
                  ),
                ),
              ),
      ),
    );
  }
}
