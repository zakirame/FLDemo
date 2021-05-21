import 'package:fl_storage/constants.dart';
import 'package:fl_storage/samples.dart';
import 'package:flutter/material.dart';
import 'package:fl_storage/utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class FileList extends StatefulWidget {
  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  String _activeTab = 'used';
  ScrollController _scrollController = new ScrollController();

  void _handleTabChange(String newValue) {
    setState(() {
      _activeTab = newValue;
    });

    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget build(BuildContext context){
    List sortedList = [...filesData];

    if (_activeTab == 'used') {
      sortedList..sort((a, b) => b['used'].compareTo(a['used']));
    }

    if (_activeTab == 'size') {
      sortedList..sort((a, b) => b['size'].compareTo(a['size']));
    }

    if (_activeTab == 'open') {
      sortedList..sort((a, b) => b['last_open'].compareTo(a['last_open']));
    }

    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              children: tabsData.map((item) => FileTab(
                item,
                _activeTab,
                _handleTabChange,
              )).toList(),
            )
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              itemCount: sortedList.length,
              itemBuilder: (BuildContext context, int index) {
                Map item = sortedList[index];
                Color itemColor = Color(int.parse("0xff${colors[item['type']]}"));

                return TouchableOpacity(
                  activeOpacity: 0.7,
                  onTap: () {
                    showAlertDialog('Alert', item['filename'], context);
                  },
                  child: Container(
                    height: 84,
                    padding: const EdgeInsets.fromLTRB(25, 0, 15, 0),
                    // color: Colors.amber[colorCodes[index]],
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 52,
                          height: 52,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Opacity(
                                    opacity: 0.15,
                                    child: SvgPicture.asset(
                                      "assets/icons/roundedShape.svg",
                                      color: itemColor,
                                      width: 52,
                                      height: 52,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 52,
                                height: 52,
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/${item['type']}.svg",
                                    color: itemColor,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    item['filename'],
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: fileTitle,
                                      height: 1.375,
                                      fontFamily: 'AvenirNextMedium',
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                      color: fileTitleColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                                  child: Text(
                                    '${item['extension']} · ${item['used']} ${numWords(item['used'])}',
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: fileDesc,
                                      height: 1.35,
                                      fontFamily: 'AvenirNextMedium',
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.none,
                                      color: fileDescColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TouchableOpacity(
                          activeOpacity: 0.7,
                          onTap: () {
                            showAlertDialog('Alert', 'File action', context);
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            child: Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/icons/dots.svg",
                                color: dotsColor,
                                width: 5,
                                height: 19,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

class FileTab extends StatelessWidget {
  final Map _data;
  final String _tab;
  final ValueChanged<String> onChange;

  FileTab(this._data, this._tab, this.onChange);

  @override
  Widget build(BuildContext context) {
    bool activeTab = _data['type'] == _tab;
    const tabStyle = TextStyle(
      fontSize: fileTab,
      height: 1.4,
      fontFamily: 'AvenirNextDemi',
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none,
      color: dotsColor,
    );
    const tabStyleActive = TextStyle(
      fontSize: fileTab,
      height: 1.4,
      fontFamily: 'AvenirNextDemi',
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none,
      color: primaryColor,
    );

    return Expanded(
      child: TouchableOpacity(
        activeOpacity: 0.7,
        onTap: () {
          onChange(_data['type']);
        },
        child: Stack(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: lineCOlor,
                    width: 1,
                  )
                )
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  _data['label'].toUpperCase(),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: activeTab ? tabStyleActive : tabStyle,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 21,
              right: 21,
              child: Container(
                height: activeTab ? 4 : 0,
                decoration: BoxDecoration(
                  color: footIconActive,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}