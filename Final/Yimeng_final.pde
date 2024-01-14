import peasy.*;
import controlP5.*;

PVector[][] vp;
color[][] colors;  // 存储颜色的数组
int total = 5;      // 色相总数
int initial = 30;    // 初始色相
int level = 6;       // 层数
float p = 50;        // 透明度，默认为50
float colorOffset = 0;  // 初始颜色偏移
boolean useQuad = true; // 是否使用 QUAD 形式

PeasyCam cam;
ControlP5 cp;

void setup() {
  size(800, 800, P3D);
  background(255);
  cam = new PeasyCam(this, 400);
  UI();
}

void draw() {
  background(255);
  noLights();
  buildCylinder();
  displayCylinder();

  cam.beginHUD();
  cp.draw();
  cam.endHUD();
  
  if (mouseX < 300 && mouseY < 300) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
}

void buildCylinder() {
  vp = new PVector[total][level];
  colors = new color[total][level];
  float angle = TWO_PI / total;

  for (int i = 0; i < total; i++) {
    float hue = (initial + i * 360 / total) % 360;
    for (int j = 0; j < level; j++) {
      float saturation = map(j, 0, level - 1, 100, 0);
      vp[i][j] = new PVector(cos(angle * i) * 100, sin(angle * i) * 100, map(j, 0, level - 1, -50, 50));
      colorMode(HSB, 360, 100, 100, 100);
      colors[i][j] = color(hue, saturation, 100, p);
    }
  }
}

void displayCylinder() {
  for (int i = 0; i < vp.length; i++) {
    for (int j = 0; j < vp[0].length; j++) {
      if (useQuad) {//色相内渐变
        fill(colors[i][j]);
      beginShape(QUAD);
      vertex(vp[i][j].x, vp[i][j].y, vp[i][j].z);
      vertex(vp[(i + 1) % vp.length][j].x, vp[(i + 1) % vp.length][j].y, vp[(i + 1) % vp.length][j].z);
      vertex(vp[(i + 1) % vp.length][(j + 1) % vp[0].length].x, vp[(i + 1) % vp.length][(j + 1) % vp[0].length].y, vp[(i + 1) % vp.length][(j + 1) % vp[0].length].z);
      vertex(vp[i][(j + 1) % vp[0].length].x, vp[i][(j + 1) % vp[0].length].y, vp[i][(j + 1) % vp[0].length].z);
      endShape(CLOSE);
    
      } else {//色相间渐变
        beginShape(QUAD);
      fill(colors[i][j]);  // 设置整个面的颜色

      // 设置每个顶点的颜色
      vertex(vp[i][j].x, vp[i][j].y, vp[i][j].z);
      fill(colors[(i + 1) % vp.length][j]);
      vertex(vp[(i + 1) % vp.length][j].x, vp[(i + 1) % vp.length][j].y, vp[(i + 1) % vp.length][j].z);
      fill(colors[(i + 1) % vp.length][(j + 1) % vp[0].length]);
      vertex(vp[(i + 1) % vp.length][(j + 1) % vp[0].length].x, vp[(i + 1) % vp.length][(j + 1) % vp[0].length].y, vp[(i + 1) % vp.length][(j + 1) % vp[0].length].z);
      fill(colors[i][(j + 1) % vp[0].length]);
      vertex(vp[i][(j + 1) % vp[0].length].x, vp[i][(j + 1) % vp[0].length].y, vp[i][(j + 1) % vp[0].length].z);

      endShape(CLOSE);
    }
    }
  }
}

void UI() {
  cp = new ControlP5(this);
  cp.addSlider("initial").setPosition(50, 50).setSize(200, 30).setRange(0, 360).setValue(initial);
  cp.addSlider("total").setPosition(50, 100).setSize(200, 30).setRange(3, 24).setValue(total);
  cp.addSlider("level").setPosition(50, 150).setSize(200, 30).setRange(1, 15).setValue(level);
  cp.addSlider("p").setPosition(50, 200).setSize(200, 30).setRange(0, 100).setValue(p);
  cp.addButton("toggleQuad").setPosition(50, 250).setSize(100, 30).setLabel("切换形式");
  cp.setAutoDraw(false);
}


void controlEvent(ControlEvent event) {
  if (event.isController()) {
    initial = (int) cp.getController("initial").getValue();
    total = (int) cp.getController("total").getValue();
    level = (int) cp.getController("level").getValue();
    p = cp.getController("p").getValue();
    // 重新构建柱体
    buildCylinder();
  }
}

void toggleQuad() {
  // 切换布尔值
  useQuad = !useQuad;
}
