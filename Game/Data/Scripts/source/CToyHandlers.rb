﻿module CToy
  def self.disable_transition
    @fuckedtransition = true
  end
  def self.enable_transition
    @fuckedtransition = false
  end
  def self.fucked_transition
    @fuckedtransition
  end
  def self.disable_fullscreen
    @fucked = true
  end
  def self.enable_fullscreen
    @fucked = false
  end
  def self.on_fullscreen
    return if @fucked
    return if $game_map && $game_map.interpreter.running?
    $syseting[:screen_size]=!$syseting[:screen_size]
    $syseting[:screen_size] ? Graphics.resize_screen(800,608) : Graphics.resize_screen(640,480)
    LogoSceneManager.scene.adapt_screen rescue nil
    SceneManager.scene.spriteset.adapt_screen rescue nil
    SceneManager.scene.adapt_screen rescue nil
    #Fuc.cur_actor.event.center(Fuc.cur_actor.event.x,Fuc.cur_actor.event.y) rescue nil
    $syseting[:screen_size] ? RGSSX.resize_window(800,608) : RGSSX.resize_window(640,480)
  end
  def self.on_f1
    his =  CToy.fps_history
    Graphics.update
    msgbox "当前: #{RGSSX.fps} FPS\n平均: #{his.inject{|k,v|k+=v} / his.size.to_f} FPS\n历史: \n#{his.each_slice(10).map{|sl|sl.join ", "}.join("\n")}"
  end
end

class << Graphics
  alias transition_fuck transition
  def transition(*args)
    return if CToy.fucked_transition
    transition_fuck(*args)
    CToy.enable_fullscreen
  end
  
  alias freeze_fuck freeze
  def freeze(*args)
    return if CToy.fucked_transition
    CToy.disable_fullscreen
    freeze_fuck(*args)
  end
  
  alias update_fuck update
  def update(*args)
    if CInput.press?($vkey[:Test])
      @a ||= 0
      @a += 1
      if @a == 10
        @a = 0
        update_fuck(*args)
      end
    else
      update_fuck(*args)
    end
  end
end