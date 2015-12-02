int SCREEN_WIDTH = 640;
int SCREEN_HEIGHT = 480;
ArrayList<Bullet> bullets;
Player player;

void setup() {
  size(640, 480, OPENGL);
  player = new Player();
  bullets = new ArrayList<Bullet>();
}

void draw() {
  background(0);
  player.moveAndDraw();
  moveBullets();
  //System.out.println(bullets.size());
}

void moveBullets() {
  for (int i = 0; i < bullets.size(); i++) {
    bullets.get(i).moveAndDraw();
  }
}

void mouseClicked() {
  bullets.add(new CircularBullet(mouseX, mouseY));
}
class Bullet {

  float xPos;
  float yPos;
  float xSpeed;
  float ySpeed;
  float hp; //a bullet with hp of 0 will disappear.
  float invincibility; //an invincible wallet can't do damage. When a bullet spawns it is invincible for a short time.
  String mode = "default"; //i feel like there will be differnet kinds of bullets
  
  Bullet(float _xPos, float _yPos) {
    xPos = _xPos;
    yPos = _yPos;
    xSpeed = 5 * random(0,100) > 50? 1 : -1;
    ySpeed = 5 * random(0,100) > 50? 1 : -1;
    invincibility = 30;
    hp = 600;
  }
  
  void moveAndDraw() {
    float alpha = map(hp, 0, 500, 0, 255); //the less health, the less visible the bullet has.
    fill(255,255,255, alpha);
    if (mode.equals("default")) {
      ellipse(xPos, yPos, 10, 10);
    }
    xPos += xSpeed;
    yPos += ySpeed;
    if (xPos >= width || xPos <= 0) xSpeed *= -1;
    if (yPos >= width || yPos <= 0) ySpeed *= -1;
    hp--;
    invincibility--;
  }
  
  boolean isInvincible() {
    return invincibility >= 0;
  }
}
/* CircularBullet:
 * A Bullet whose path is circular instead of straight.
 * Does not bounce off walls.
 */

class CircularBullet extends Bullet {
  float centerX; //origin from which the bullet spins w/respect to.
  float centerY;
  float r = 0;
  float theta = 0;
  float offset = .5;
  
  CircularBullet(float _xPos, float _yPos) {
    super(_xPos, _yPos);
    centerX = _xPos;
    centerY = _yPos;
    hp = 500;
  }

  void moveAndDraw() {
    float x = (r + offset) * cos(theta);
    float y = (r + offset) * sin(theta);
    noStroke();
    float alpha = map(hp, 0, 500, 0, 255); //transparency
    fill(255, alpha);
    xPos = x+centerX;
    yPos = y+centerY;
    ellipse(xPos, yPos, 20, 20); 
    hp--;
    invincibility--;

    theta += 0.02;
    r += 0.7;
  }
}

/* Player: A playable triangle that spawns bullets, and 
 *         tasked with avoiding them at the same time.
 */
class Player {
  float xPos;
  float yPos;
  float radius = 20;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  int myFrame = 0;
  int health = 1000;

  Player() {
    setCoordinatesToMouse();
  }

  void moveAndDraw() {
    updateBullets();
    removeDeadBullets();
    drawPlayer();
    drawBullets();
    checkBulletCollision();
    myFrame = (myFrame+1) % 10000;
    fill(255);
    textSize(15);
    text("Health: " + health, xPos, yPos);
  }

  void drawPlayer() {
    fill(255);
    setCoordinatesToMouse();
    float r = radius;
    triangle(xPos-r, yPos+r, xPos, yPos-r, xPos+r, yPos+r);
  }

  void updateBullets() {
    if (myFrame % 20 == 0) {
      bullets.add(new Bullet(xPos, yPos));
    }
    if (myFrame % 30 == 0) {
      bullets.add(new CircularBullet(xPos, yPos));
    }
  }
  
  void drawBullets() {
    for (int i = 0; i < bullets.size(); i++) {
      bullets.get(i).moveAndDraw();
    }
  }
  
  void removeDeadBullets() {
    for (int i = 0; i < bullets.size(); i++) {
      Bullet curr = bullets.get(i);
      if (curr.hp <= 0) {
        bullets.remove(curr);
      }
    }
  }


  void checkBulletCollision() {
    for (int i = 0; i < bullets.size(); i++) {
      Bullet curr = bullets.get(i);
      if (dist(xPos, yPos, curr.xPos, curr.yPos) <= radius && !curr.isInvincible()) {
        bullets.remove(curr);
        health--;
      }
    }
  }
  
  
  void setCoordinatesToMouse() {
    xPos = mouseX;
    yPos = mouseY;
  }
}


