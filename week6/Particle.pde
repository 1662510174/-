class Particle {
  float size;
  int particleColor;
  PVector pos;
  PVector vel;
  PVector acc;
  PVector target;
  boolean isEdgeParticle;
  
  Particle(float x, float y, float pSize, boolean isEdge) {
    size = pSize;
    particleColor = color(0);
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    target = null;
    isEdgeParticle = isEdge;
  }

  void move() {
    vel.mult(0.99);

    if (target != null) {
      seekTarget();

      if (vel.mag() > speedToTriggerDynState) {
        makeDynamic();
      }
    } 

    avoidMouse();

    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }

 void avoidMouse() {
  float mouseDist = dist(pos.x, pos.y, mouseX, mouseY);
  float mouseThresh = 100;

  if (mouseDist < mouseThresh) {
    PVector pushForce = new PVector(pos.x, pos.y);
    pushForce.sub(new PVector(mouseX, mouseY));
    pushForce.normalize();
    pushForce.mult((mouseThresh - mouseDist) * 0.0025);
    acc.add(pushForce);
  }
}


  void seekTarget() {
    float targetDist = dist(pos.x, pos.y, target.x, target.y);
    float speedMultiplier = 1;
    float distThresh = 50;

    if (targetDist < distThresh) {
      speedMultiplier = targetDist / distThresh;
    }

    if (targetDist > 1) {
      PVector steer = new PVector(target.x, target.y);
      steer.sub(pos);
      steer.normalize();
      steer.mult(0.05 * speedMultiplier);
      acc.add(steer);
    }
  }

  void makeDynamic() {
    target = null;
    size = random(0.25, 3);
    if (isEdgeParticle) {
      particleColor = color(random(255), random(255), random(255));
    } else {
      particleColor = color(0);
    }
  }

  void display() {
    fill(particleColor);
    noStroke();
    ellipse(pos.x, pos.y, size, size*2);
  }
}
