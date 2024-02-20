/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-17 20:53:22
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-18 19:55:37
 * @FilePath: /pet/lib/common/photoScreen.dart
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoScreen extends StatefulWidget {
  final List imgList;
  final int index;
  final GestureTapCallback? onLongPress;

  const PhotoScreen({
    super.key,
    required this.imgList,
    required this.index,
    this.onLongPress,
  });

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  int _currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.index);
    setState(() {
      _currentIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('${_currentIndex + 1}/${widget.imgList.length}'),
        backgroundColor: Colors.black,
        leading: const SizedBox(),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, size: 30, color: Colors.white),
            onPressed: () => Get.back(result: false),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        color: Colors.black,
        child: SizedBox(
          height: 50,
          child: IconButton(
            icon: const Icon(Icons.download_rounded,
                size: 30, color: Colors.white),
            onPressed: () {
              // -------- 保存 -------
              // CommonUtil.saveToAlbum([widget.imgList[_currentIndex]]);
            },
          ),
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          onLongPress: widget.onLongPress,
          child: Container(
            color: Colors.black,
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.imgList[index]),
                );
              },
              itemCount: widget.imgList.length,
              backgroundDecoration: null,
              pageController: _controller,
              enableRotation: true,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
