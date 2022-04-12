class GetVideosModel {
  bool? success;
  List<VideoData>? videoList;

  GetVideosModel({
    this.success,
    this.videoList,
  });

  GetVideosModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      videoList = [];
      json['data'].forEach((v) {
        videoList!.add(VideoData.fromJson(v));
      });
    }
  }
}

class VideoData {
  String? videoId;
  String? videoTitle;
  String? videoUrl;
  String? videoDescription;

  VideoData(
      {this.videoId, this.videoTitle, this.videoUrl, this.videoDescription});

  VideoData.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    videoTitle = json['video_title'];
    videoUrl = json['video_url'];
    videoDescription = json['video_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['video_id'] = videoId;
    data['video_title'] = videoTitle;
    data['video_url'] = videoUrl;
    data['video_description'] = videoDescription;
    return data;
  }
}
