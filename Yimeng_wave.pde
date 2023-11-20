Wave[] waves;
color[] customColors = new color[5];
void setup() {
  size(640, 360);
  frameRate(30);
  

  int numTotalWaves = 5;
  float xspacing = 1;
  int w = width + 16;

  waves = new Wave[numTotalWaves];

  for (int i = 0; i < numTotalWaves; i++) {
    waves[i] = new Wave(5, xspacing, w); 
  }
}

void draw() {
  background(255, 252, 242);

  

  for (int i = 0; i < waves.length; i++) {
    waves[i].calcWave(1);
    float verticalStretch = map(i, 0, waves.length - 1, 0.5, 5.0); 
    waves[i].renderWave(1, verticalStretch);
     }
  saveFrame("output/frame-######.png");
}
