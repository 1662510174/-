PImage img;
ArrayList<Particle> particles;

void setup() {
  size(850, 850);
  img = loadImage("萌.jpg");  // 替换成你的图像文件路径
  particles = new ArrayList<Particle>();

  // 进行边缘检测
  img.filter(THRESHOLD, 1);

  // 在边缘位置创建粒子
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      if (brightness(img.get(x, y)) > 127) {
        Particle p = new Particle(x, y);
        particles.add(p);
      }
    }
  }
}

void draw() {
  background(255);

  // 移动和显示粒子
  for (Particle p : particles) {
    p.move();
    p.display();
  }
}
