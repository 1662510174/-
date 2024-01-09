float zoom = 1.0;  // 初始化缩放因子
float centerX, centerY;  // 画面中心坐标
float n;  
float hueBase = 0; // 初始色相

void setup() {
  size(640, 360);
  centerX = width / 2.0;
  centerY = height / 2.0;
  colorMode(HSB, 360, 100, 100);  
}

void draw() {
  loadPixels();
  float w = 16.0;            // 2D 空间宽度
  float h = 16.0;            // 2D 空间高度
  float dx = w / width;      // 每个像素在 x 方向的增量
  float dy = h / height;     // 每个像素在 y 方向的增量
  float x = -w/2;            //  x 坐标从 -1 * width / 2 开始
  
  // 根据缩放因子进行画布缩放
  translate(centerX, centerY);
  scale(zoom);
  translate(-centerX, -centerY);
  
  for (int i = 0; i < width; i++) {
    float y = -h/2;          // 从 -1 * height / 2 开始的 y 坐标
    for (int j = 0; j < height; j++) {
      float r = sqrt((x*x) + (y*y));     // 将笛卡尔坐标转换为极坐标
      float theta = atan2(y, x);          // 将笛卡尔坐标转换为极坐标
      // 计算 2D 极坐标方程
      float val = sin(n * cos(r) + 5 * theta);  // 结果在 -1 到 1 之间
      
      // 计算距离中心的距离
      float d = dist(centerX, centerY, i, j);
      
      // 映射颜色，基础色相加上距离的渐变
      float hue = (hueBase + d * 0.5) % 360; // 色相渐变
      // 使用 HSB 设置颜色
      pixels[i + j * width] = color(hue,  100, val * 50 + 50);  // 映射到 HSB 范围
      
      y += dy;  // 增加 y
    }
    x += dx;  // 增加 x
  }
  updatePixels();
  
  // 检测鼠标滚轮的滚动
  float delta = 0.01;  // 缩放增量
  if (mouseEvent != null && mouseEvent.getCount() != 0) {
    // 根据滚轮滚动的方向调整缩放因子
    zoom += delta * mouseEvent.getCount();
  }
  
  n += 0.02; 
  
  // 循环变化基础色相
  hueBase = (hueBase + 0.5) % 360;
}


void mousePressed() {
  // 重置 n 的值为鼠标水平位置
  n = mouseX * 0.02;  
}
 
