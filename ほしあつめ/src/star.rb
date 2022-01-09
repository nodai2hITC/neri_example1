class Star < Sprite
  STAR_IMAGE = Image.load("image/star.png")

  def initialize(x, y)
    super(x, y, STAR_IMAGE)
    self.offset_sync = true
    self.collision = [24, 24, 24]
  end
end
