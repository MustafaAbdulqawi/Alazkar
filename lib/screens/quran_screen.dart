import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController _pdfController;
  final ScrollController _scrollController = ScrollController();

  int? _selectedSuraIndex;

  final List<Map<String, dynamic>> _suraIndex = [
    {'name': 'الفاتحة', 'page': 1},
    {'name': 'البقرة', 'page': 2},
    {'name': 'آل عمران', 'page': 45},
    {'name': 'النساء', 'page': 69},
    {'name': 'المائدة', 'page': 95},
    {'name': 'الأنعام', 'page': 115},
    {'name': 'الأعراف', 'page': 136},
    {'name': 'الأنفال', 'page': 160},
    {'name': 'التوبة', 'page': 169},
    {'name': 'يونس', 'page': 187},
    {'name': 'هود', 'page': 199},
    {'name': 'يوسف', 'page': 213},
    {'name': 'الرعد', 'page': 225},
    {'name': 'إبراهيم', 'page': 231},
    {'name': 'الحجر', 'page': 237},
    {'name': 'النحل', 'page': 242},
    {'name': 'الإسراء', 'page': 255},
    {'name': 'الكهف', 'page': 266},
    {'name': 'مريم', 'page': 277},
    {'name': 'طه', 'page': 284},
    {'name': 'الأنبياء', 'page': 294},
    {'name': 'الحج', 'page': 303},
    {'name': 'المؤمنون', 'page': 311},
    {'name': 'النور', 'page': 319},
    {'name': 'الفرقان', 'page': 329},
    {'name': 'الشعراء', 'page': 335},
    {'name': 'النمل', 'page': 345},
    {'name': 'القصص', 'page': 354},
    {'name': 'العنكبوت', 'page': 364},
    {'name': 'الروم', 'page': 371},
    {'name': 'لقمان', 'page': 377},
    {'name': 'السجدة', 'page': 381},
    {'name': 'الأحزاب', 'page': 383},
    {'name': 'سبأ', 'page': 393},
    {'name': 'فاطر', 'page': 399},
    {'name': 'يس', 'page': 404},
    {'name': 'الصافات', 'page': 410},
    {'name': 'ص', 'page': 417},
    {'name': 'الزمر', 'page': 422},
    {'name': 'غافر', 'page': 431},
    {'name': 'فصلت', 'page': 439},
    {'name': 'الشورى', 'page': 445},
    {'name': 'الزخرف', 'page': 451},
    {'name': 'الدخان', 'page': 457},
    {'name': 'الجاثية', 'page': 460},
    {'name': 'الأحقاف', 'page': 464},
    {'name': 'محمد', 'page': 468},
    {'name': 'الفتح', 'page': 472},
    {'name': 'الحجرات', 'page': 477},
    {'name': 'ق', 'page': 479},
    {'name': 'الذاريات', 'page': 482},
    {'name': 'الطور', 'page': 485},
    {'name': 'النجم', 'page': 487},
    {'name': 'القمر', 'page': 490},
    {'name': 'الرحمن', 'page': 493},
    {'name': 'الواقعة', 'page': 496},
    {'name': 'الحديد', 'page': 499},
    {'name': 'المجادلة', 'page': 504},
    {'name': 'الحشر', 'page': 507},
    {'name': 'الممتحنة', 'page': 510},
    {'name': 'الصف', 'page': 513},
    {'name': 'الجمعة', 'page': 515},
    {'name': 'المنافقون', 'page': 516},
    {'name': 'التغابن', 'page': 518},
    {'name': 'الطلاق', 'page': 520},
    {'name': 'التحريم', 'page': 522},
    {'name': 'الملك', 'page': 524},
    {'name': 'القلم', 'page': 526},
    {'name': 'الحاقة', 'page': 529},
    {'name': 'المعارج', 'page': 531},
    {'name': 'نوح', 'page': 533},
    {'name': 'الجن', 'page': 535},
    {'name': 'المزمل', 'page': 537},
    {'name': 'المدثر', 'page': 538},
    {'name': 'القيامة', 'page': 540},
    {'name': 'الإنسان', 'page': 542},
    {'name': 'المرسلات', 'page': 544},
    {'name': 'النبأ', 'page': 545},
    {'name': 'النازعات', 'page': 547},
    {'name': 'عبس', 'page': 549},
    {'name': 'التكوير', 'page': 550},
    {'name': 'الانفطار', 'page': 551},
    {'name': 'المطففين', 'page': 552},
    {'name': 'الانشقاق', 'page': 553},
    {'name': 'البروج', 'page': 554},
    {'name': 'الطارق', 'page': 555},
    {'name': 'الأعلى', 'page': 556},
    {'name': 'الغاشية', 'page': 557},
    {'name': 'الفجر', 'page': 557},
    {'name': 'البلد', 'page': 559},
    {'name': 'الشمس', 'page': 559},
    {'name': 'الليل', 'page': 560},
    {'name': 'الضحى', 'page': 561},
    {'name': 'الشرح', 'page': 561},
    {'name': 'التين', 'page': 562},
    {'name': 'العلق', 'page': 562},
    {'name': 'القدر', 'page': 563},
    {'name': 'البينة', 'page': 563},
    {'name': 'الزلزلة', 'page': 564},
    {'name': 'العاديات', 'page': 564},
    {'name': 'القارعة', 'page': 565},
    {'name': 'التكاثر', 'page': 565},
    {'name': 'العصر', 'page': 566},
    {'name': 'الهمزة', 'page': 566},
    {'name': 'الفيل', 'page': 566},
    {'name': 'قريش', 'page': 567},
    {'name': 'الماعون', 'page': 567},
    {'name': 'الكوثر', 'page': 567},
    {'name': 'الكافرون', 'page': 568},
    {'name': 'النصر', 'page': 568},
    {'name': 'المسد', 'page': 568},
    {'name': 'الإخلاص', 'page': 569},
    {'name': 'الفلق', 'page': 569},
    {'name': 'الناس', 'page': 569},
  ];

  @override
  void initState() {
    super.initState();
    _pdfController = PdfViewerController();
  }

  void _showSuraIndex() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_selectedSuraIndex != null) {
        _scrollController.jumpTo(_selectedSuraIndex! * 50.0);
      }
    });

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          controller: _scrollController,
          itemCount: _suraIndex.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_suraIndex[index]['name']),
              trailing: _selectedSuraIndex == index
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                setState(() {
                  _selectedSuraIndex = index;
                });
                int pageNumber = _suraIndex[index]['page'];
                _pdfController.jumpToPage(pageNumber);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFffffff),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0XFFffffff),
        title: const Text("القرآن الكريم"),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book),
            onPressed: _showSuraIndex,
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 600,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: !kIsWeb
                  ? SfPdfViewer.asset(
                      'assets/Noor-Book.com  القران الكريم.pdf',
                      key: _pdfViewerKey,
                      controller: _pdfController,
                      scrollDirection: PdfScrollDirection.horizontal,
                      pageSpacing: 0,
                      enableDoubleTapZooming: false,
                    )
                  : SfPdfViewer.network(
                      'https://www.quran-pdf.com/arabic-quran.pdf',
                      key: _pdfViewerKey,
                      controller: _pdfController,
                      scrollDirection: PdfScrollDirection.horizontal,
                      pageSpacing: 0,
                      enableDoubleTapZooming: false,
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  _pdfController.nextPage();
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  _pdfController.previousPage();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
