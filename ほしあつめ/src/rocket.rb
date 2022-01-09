class Rocket < Sprite
  ROCKET_IMAGE = Image.load("image/rocket.png")

  def initialize(x, y)
    super(x, y, ROCKET_IMAGE)
    self.offset_sync = true
    @speed = 0
    self.angle = 0
    self.collision = [24, 24, 16]
  end

  def update
    self.angle += Input.x * 2 # ← → キーに応じて、ロケットの向きを変更。
    self.speed -= Input.y * 0.05 # ↑で加速、↓で減速。
    self.speed = self.speed.clamp(0, 5) # 0以上5以下に

    self.x += self.speed * Math.cos(2 * Math::PI * self.angle / 360)
    self.y += self.speed * Math.sin(2 * Math::PI * self.angle / 360)
    self.x = self.x.clamp(10, 630)
    self.y = self.y.clamp(10, 470)
  end

  attr_accessor :speed
end
