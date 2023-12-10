PImage[] images;
PImage croppedImage;
int x;
int y = 0;
int w = 240;
int h = 240;
int num = 6;//帧数

void setup() {
  size(240, 240);
  images = new PImage[num];  // 加载图像并设置到数组中

  for (int i = 0; i < num; i++) {
    images[i] = loadImage("海獭旋转_000" + i + ".png");
  }

  croppedImage = createImage(w, h, RGB);  // 创建一个新的图像对象

  // 读取每一帧特定位置的像素
  for (int i = 0; i < num; i++) {
    for (int e = 0; e * num < w; e++) {
      x = e * num + i;
      int d = 1;//设置每一次读取的像素带宽度
      croppedImage.copy(images[i], x, y, d, h, x, y, d, h);
    }
  }
}

void draw() {
  // 在画布上显示最终图像
  background(255);
  image(croppedImage, 0, 0);
}

