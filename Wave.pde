class Wave {
  float[] angles;
  float[] amplitudes;
  float[] frequencies;
  float[] yvalues;
  float theta;

  Wave(int numWaves, float xspacing, int w) {
    angles = new float[numWaves];
    amplitudes = new float[numWaves];
    frequencies = new float[numWaves];
    yvalues = new float[w / int(xspacing)];
    theta = 0.0;

    for (int i = 0; i < numWaves; i++) {
      angles[i] = random(TWO_PI);
      amplitudes[i] = random(10, 30);
      frequencies[i] = random(0.02, 0.1);
    }
  }

  void calcWave(float xspacing) {
    theta += 0.02;

    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = 0;
    }

    for (int j = 0; j < angles.length; j++) {
      float x = theta;
      for (int i = 0; i < yvalues.length; i++) {
        if (j % 2 == 0)  yvalues[i] += sin(x) * amplitudes[j];
        else yvalues[i] += cos(x) * amplitudes[j];
        x += frequencies[j];
      }
    }
  }

  void renderWave(float xspacing, float verticalStretch) {
    noStroke();
    int[] customColors = new int[5]; // 指定数组大小即颜色数量

    customColors[0] = color(255, 247, 232);   
    customColors[1] = color(235, 232, 255);   
    customColors[2] = color(255, 232, 240);   
    customColors[3] = color(235, 232, 255); 
    customColors[4] = color(255, 232, 240); 

    ellipseMode(CENTER);
    for (int x = 0; x < yvalues.length; x++) {
      int randomIndex = int(random(customColors.length));
      fill(customColors[randomIndex]);
      ellipse(x * xspacing, height / 2 + yvalues[x] * verticalStretch, 16, 16);
    }
  }
}
