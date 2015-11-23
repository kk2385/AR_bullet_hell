int SCREEN_WIDTH = 500;
int SCREEN_HEIGHT = 500;
ArrayList<Bullet> bullets;

void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  bullets = new ArrayList<Bullet>();
}

void draw() {
  background(0);
  for (int i = 0; i < bullets.size(); i++) {
    bullets.get(i).moveAndDraw();
  }
  System.out.println(bullets.size());
}

void mouseClicked() {
  bullets.add(new Bullet(mouseX, mouseY));
}
