class UFO < Sprite
  UFO_IMAGE = Image.load("image/ufo.png")

  def initialize(x, y, vx = nil, vy = nil)
    super(x, y, UFO_IMAGE)
    self.offset_sync = true
    angle = rand(0..359)
    @vx = vx || 3 * Math.cos(2 * 3.14 * angle / 360)
    @vy = vy || 3 * Math.sin(2 * 3.14 * angle / 360)
    self.collision = [24, 24, 14]
  end

  def update
    self.x += self.vx
    self.y += self.vy
    # 画面端に来たら反射
    self.vx = -self.vx  if  self.x < 0  ||  self.x > 640
    self.vy = -self.vy  if  self.y < 0  ||  self.y > 480
  end

  attr_accessor :vx, :vy
end
