float d = 200;      // 初始直径
float h = 200;      // 初始高度
int sides = 6;       // 初始侧边数量
int layers = 10;     // 初始层数
int p = 180;         //初始不透明度
boolean changeColor = false;  // 改变颜色的布尔值

void setup() {
  size(800, 600, P3D);
  noStroke();
}

void draw() {
  background(255);
  lights();
  camera();
  translate(width / 2, height / 2);
  rotateX(PI/3.0);

  // 检查是否改变颜色
  if (changeColor) {
    drawCylinder(true);   // 使用新颜色
    changeColor = false;  // 重置标志，使得颜色只改变一次
  } else {
    drawCylinder(false);  // 使用当前颜色
  }
}

void drawCylinder(boolean randomColor) {
  float angleIncrement = TWO_PI / sides;

  for (int j = 0; j < layers; j++) {
    float layerHeight = map(j, 0, layers - 1, -h / 2, h / 2);
    for (int i = 0; i < sides; i++) {
      float x1 = cos(i * angleIncrement) * d / 2;
      float y1 = sin(i * angleIncrement) * d / 2;
      float x2 = cos((i + 1) * angleIncrement) * d / 2;
      float y2 = sin((i + 1) * angleIncrement) * d / 2;

      float x3 = cos(i * angleIncrement) * d / 2;
      float y3 = sin(i * angleIncrement) * d / 2;
      float x4 = cos((i + 1) * angleIncrement) * d / 2;
      float y4 = sin((i + 1) * angleIncrement) * d / 2;

      // 根据控制颜色的布尔值决定是否使用新颜色
      if (randomColor) {
        fill(random(255), random(255), random(255), p);
      }


      beginShape(QUAD);
      vertex(x1, y1, layerHeight);
      vertex(x2, y2, layerHeight);
      vertex(x4, y4, layerHeight + h / layers);
      vertex(x3, y3, layerHeight + h / layers);
      endShape(CLOSE);
    }
  }
}

void keyPressed() {
  if (key == 'A' || key == 'a') {
    d -= 10;
  } else if (key == 'D' || key == 'd') {//‘A’减少宽度，‘D’增加宽度
    d += 10;
  } else if (key == 'W' || key == 'w') {
    h += 10;
  } else if (key == 'S' || key == 's') {//‘W'增加高度，‘S’减少高度
    h -= 10;
  } else if (keyCode == LEFT) {
    sides = max(3, sides - 1);
  } else if (keyCode == RIGHT) {
    sides++;
  } else if (keyCode == UP) {
    layers++;
  } else if (keyCode == DOWN) {//左右箭头改变侧边数量，上下箭头改变层次数量
    layers = max(1, layers - 1);
  } else if (key == 'Q' || key == 'q') {
    p -= 20;
  } else if (key == 'E' || key == 'e') {//‘Q’减少透明度，‘E’增加透明度
    p += 20;
  } else if (key == 'C' || key == 'c') {
    changeColor = true;  // ‘C'改变颜色
  }
  // 设置直径、高度、侧边数量和层数的范围
  d = constrain(d, 10, 600);
  h = constrain(h, 10, 600);
  p = constrain(p, 1, 260);
  sides = constrain(sides, 3, 30);
  layers = constrain(layers, 2, 30);
  println(p);//显示不透明度
}
