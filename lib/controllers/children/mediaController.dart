import 'package:bassel/models/children/media.dart';
import 'package:bassel/services/children/mediaService.dart';
import 'dart:async';

class MediaController {
  MediaService mediaService = new MediaService();


  Future<int> saveMedia(Media media) async{
    return await this.mediaService.saveMedia(media);
  }

  Future<List> getAllMedia() async{
    return await this.mediaService.getAllMedia();
  }

  Future<List> getItemMedias(int tableid,int itemId) async{
    return await this.mediaService.getItemMedias(tableid, itemId);
  }



  Future<int> getMediaCount () async{
    return await this.mediaService.getMediaCount();
  }



  Future<int> updateMedia(Media media) async{
    return await this.mediaService.updateMedia(media);
  }

  Future<int> deleteMedia(Media media) async{
    return await this.mediaService.deleteMedia(media);
  }

  close() async{
    return await this.mediaService.close();
  }
}