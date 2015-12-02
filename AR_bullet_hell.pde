int SCREEN_WIDTH = 640;
int SCREEN_HEIGHT = 480;
ArrayList<Bullet> bullets;
Player player;
BulletGenerator generator;

void setup() {
  size(640, 480, OPENGL);
  player = new Player();
  generator = new BulletGenerator(width/2, height/2);
  noCursor();
  bullets = new ArrayList<Bullet>();
}

void draw() {
  background(0);
  bullets = generator.move();
  player.moveAndDraw(bullets);
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
