require "dxruby"

require "./src/rocket"
require "./src/star"
require "./src/ufo"

rocket = Rocket.new(320, 240)
star = Star.new(rand(40..600), rand(40..440))
ufos = [UFO.new(100, 100, -2, -2)]

font = Font.new(24)

score = 0
mode = 1

TITLE = <<~TITLE
  ほしあつめ

  ロケットを操作し、ＵＦＯを避けつつ☆を集めましょう。
  ↑で加速、← →で回転、↓で減速。

  スペースキーを押すと開始します。
TITLE

SECRET_MESSAGE = File.read("data/secret.txt", encoding: "utf-8")

Window.caption = "ほしあつめ"
Window.loop do
  case mode
  when 1 # タイトル画面
    Window.draw_font(100, 100, TITLE, font)
    mode = 2 if Input.key_push?(K_SPACE)
    next
  when 3 # ゲームオーバー画面
    Window.draw_font(100, 100, "ゲームオーバー", font)
    Window.draw_font(200, 200, "スコア：#{score}", font)
    Window.draw_font(200, 250, SECRET_MESSAGE, font) if score >= 10
    exit if Input.key_push?(K_SPACE)
    next
  end

  Sprite.update(rocket)
  Sprite.update(star)
  Sprite.update(ufos)

  # ロケットと ☆ の衝突判定
  if Sprite.check(rocket, star)
    # ロケットと☆が当たった場合
    score += 1
    # ☆ の位置を新たな位置に変更する。
    star.x = rand(40..600)
    star.y = rand(40..440)
    # UFO を追加
    new_ufo = UFO.new(ufos.first.x, ufos.first.y)
    ufos.push(new_ufo)
  end

  # ロケットとＵＦＯの衝突判定
  if Sprite.check(rocket, ufos)
    mode = 3 # 当たったらゲームオーバー
  end

  Sprite.draw(rocket)
  Sprite.draw(star)
  Sprite.draw(ufos)
end
