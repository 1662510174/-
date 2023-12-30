class Particle {
  float x, y;
  float speedX, speedY;

  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    this.speedX = random(-2, 2);
    this.speedY = random(-2, 2);
  }

  void move() {
    x += speedX;
    y += speedY;
  }

  void display() {
    fill(0);
    noStroke();
    ellipse(x, y, 5, 5);
  }
}
