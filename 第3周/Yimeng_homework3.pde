float space1 = 10;
float space2 = 30;
int[] ys = {10, 80, 160, 260, 375, 50, 280, 100, 550};

void setup() {
  size(600, 600);
  background(255);
}

void draw() {
  for (int i = 0; i < ys.length; i++) {
    int y = ys[i];
    for (float x = 0; x < width; x += space1) {
      noStroke();
      float r = random(0, 20);
      if (r<2) {
        fill(255, 224, 235);
      } else if (r<8) {
        fill(254, 255, 224);
      } else {
        fill(224, 248, 255);
      }
      square(x, y, space1);
      square(y, x, space1);
    }
  }//小色块颜色随机
  //大色块指定色彩
  fill(255, 224, 235);//粉
  rect(270, 290, 10, 85);
  rect(385, 90, 165, 10);
  rect(110, 560, 50, 20);
  square(290, 290, 85);
  fill(224, 248, 255);//蓝
  square(310, 310, 45);
  square(60, 60, 20);
  rect(170, 270, 90, 10);
  rect(490, 530, 85, 20);
  rect(360, 110, 15, 50);
  rect(170, 385, 90, 10);
  fill(254, 255, 224);//黄
  rect(50, 400, 50, 20);
  rect(525, 480, 25, 50);
  rect(510, 20, 20, 60);
  square(110, 110, 50);

  noLoop();  // 保证 draw 只运行一次，避免无限循环!!!!!!!!在这儿卡了好久
}
