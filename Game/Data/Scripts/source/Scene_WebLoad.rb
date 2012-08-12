﻿#encoding:utf-8
#==============================================================================
# ■ Scene_WebLoad
#------------------------------------------------------------------------------
# 　读档画面
#==============================================================================

class Scene_WebLoad < Scene_WebFile
  #--------------------------------------------------------------------------
  # ● 获取帮助窗口的文本
  #--------------------------------------------------------------------------
  def help_window_text
    Vocab::LoadMessage
  end
  #--------------------------------------------------------------------------
  # ● 获取开始时文件索引的位置
  #--------------------------------------------------------------------------
  def first_savefile_index
    0
  end
  #--------------------------------------------------------------------------
  # ● 确定读档文件
  #--------------------------------------------------------------------------
  def on_savefile_ok
    super
    if DataManager.load_web_game(@index)
      on_load_success
    else
      Sound.play_buzzer
    end
  end
  #--------------------------------------------------------------------------
  # ● 读档成功时的处理
  #--------------------------------------------------------------------------
  def on_load_success
    Sound.play_load
    fadeout_all
    $game_system.on_after_load
    SceneManager.goto(Scene_Map)
  end
end