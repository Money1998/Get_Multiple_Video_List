
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_video_list/BLoC/cubit/video_cubit.dart';
import 'package:multi_video_list/Model/getVideoModel.dart';
import 'package:video_player/video_player.dart';
import 'package:multi_video_list/BLoC/state/video_state.dart';
import 'package:multi_video_list/WidgetUI/video_list_item.dart';
import 'package:multi_video_list/Common/global.dart';
import 'package:multi_video_list/Common/sizeConfig.dart';
import 'package:flutter/material.dart';

class GetVideoListPage extends StatefulWidget {
  const GetVideoListPage({Key? key}) : super(key: key);

  @override
  _GetVideoListPageState createState() => _GetVideoListPageState();
}

class _GetVideoListPageState extends State<GetVideoListPage> {
  List<VideoData> videoList = [];
  bool isProgress = true;

  @override
  void initState() {
    loadVideos();
    super.initState();
  }

  void loadVideos() async {
    final videoCubit = BlocProvider.of<VideoCubit>(context, listen: false);
    await videoCubit.getVideos();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(title: Text(videoListShowPage)),
      body: BlocConsumer<VideoCubit, VideoState>(
        listener: (context, state) {
          if (state is VideoError) {
            showSnackBarMsg(context, state.message);
          }
          if (state is GetVideoCompleted) {
            GetVideosModel result = state.videosModel;
            if (result.success == true) {
              videoList.clear();
              videoList.addAll(result.videoList!);
              isProgress = false;
              // print('VideoList: $videoList');
              setState(() {});
            } else {
              showSnackBarMsg(context, getVideoError);
            }
          }
        },
        builder: (context, state) {
          if (state is! Processing) {
            return videoList.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: videoList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          topSection(videoList[index].videoDescription!,
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight! /3.5,
                            child: VideoListItem(
                              videoPlayerController:
                              VideoPlayerController.network(
                                  videoList[index].videoUrl!),
                              looping: true,
                            ),
                          ),
                        ],
                      );
                    })
                : Container();
          }
          return Visibility(
            visible: isProgress,
            child: Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.08),
                child: const Center(
                  child: CircularProgressIndicator(),
                )),
          );
        },
      ),
    );
  }

  Widget topSection(String videoDescription) {
    return Container(
      height: 70.0,
      width: SizeConfig.screenWidth,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text("Description => $videoDescription",style: mediumTxtStyle,maxLines: 3),
        ),
      ]),
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      color: Colors.blue[200],
    );
  }
}
