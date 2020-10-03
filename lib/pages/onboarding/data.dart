class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Online classes taught by the world's best.\nGordon Ramsay, Stephen Curry, and more.");
  sliderModel.setTitle("Learn from the best");
  sliderModel.setImageAssetPath("assets/onboarding/1.jpg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Download up to 10 digestible lessons that you\ncan watch offline at any time.");
  sliderModel.setTitle("Download and watch anytime");
  sliderModel.setImageAssetPath("assets/onboarding/2.jpg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Perfect homemade paste, or write a novel...\nAll wit acess 100+ class.");
  sliderModel.setTitle("Explore a range of topics");
  sliderModel.setImageAssetPath("assets/onboarding/3.jpg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}