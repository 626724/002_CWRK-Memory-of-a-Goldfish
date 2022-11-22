class TileModel{
   bool isSelected = false;
   String imageAssetPath = '';
   TileModel({required this.imageAssetPath, required this.isSelected});

   void setImageAssetPath(String getImageAssetPath){
      imageAssetPath = getImageAssetPath;
   }
   void setIsSelected(bool getIsSelected){
      isSelected = getIsSelected;
   }
   String getImageAssetPath(){
      return imageAssetPath;
   }
   bool getIsSelected(){
      return isSelected;
   }

}

class NetworkTileModel{
   bool isSelected = false;
   String imageURL = '';
   NetworkTileModel({required this.imageURL, required this.isSelected});

   void setImageAssetPath(String getImageAssetPath){
      imageURL = getImageAssetPath;
   }
   void setIsSelected(bool getIsSelected){
      isSelected = getIsSelected;
   }
   String getImageAssetPath(){
      return imageURL;
   }
   bool getIsSelected(){
      return isSelected;
   }

}