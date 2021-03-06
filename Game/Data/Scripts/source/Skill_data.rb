﻿#
class FuckEachOther < Skill
  
  def set_ui
    @icon = "bo"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 1
    @name = "意念抛投"
    @init_skill = true
    @use_req = "sp>=4&&ap>=4"
    @use_dis_min = 1
    @use_dis_max = 6
    @hotkey = 0x44
    @hurt_enemy = true
    @hurt_partner = true
    @hurt_p_dead = true
    @hurt_e_dead = true
    @hurt_nothing = false
    @hurt_cant_move = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "需要4点怒气以及4点行动力催动.\n选中一个友方单位或是智力低于自己的敌人.\n向指定的目标格抛出.\n若指定目标格为空地,则无事.\n若指定目标格为敌人或友军.\n行动力不足以攻击的一方受到伤害.\n伤害与被投掷者生命有关.\n施法距离:1-6\n\n特殊效果:\n若投掷男主角.\n目标区域伤害为3格范围.\n若投掷目标向男主角.\n则有一定概率秒杀被投掷单位."
  end
  
  def set_extra
    @spec_effect = "if !i.is_a?(Fucker) && i.int>=@cur_actor.int;
                      tempb << [false,21];
                    else;
                      tempb << [true,0];
                      i.event.animation_id = 4;
                      i.add_buff(Catch.new(@cur_actor));
                    end"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = false
  end

end

class FuckWithOutMoney < Skill
  
  def set_ui
    @icon = "fuckall"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 2
    @name = "投掷"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 6
    @hotkey = 0x44
    @hurt_enemy = true
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_nothing = true
    @hurt_cant_move = true
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 4
    @hp_cost = 0
    @ap_cost = 4
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "消耗4点怒气和4点行动力.\n将选中的单位投向目标地点.\n造成物理伤害,无视魔法免疫.\n施法距离:1-6"
  end

  def set_extra
    @spec_effect = "target_body = $team_set.find{|i| i.x==para[1][0]&&i.y==para[1][1]};
                    return [[false,13]] if !$game_map.check_passage(*para[1],0xF)||!target_body&&$game_map.events_xy_nt(*para[1]).size>0;
                    $team_set.each do |i|;
                      relate = (i.team&target_body.team).size==0 if target_body
                      dx=para[1][0]-i.x;
                      dy=para[1][1]-i.y;
                      if dx==0&&dy==0;
                        target_body=i;
                      end;
                      if i.in_buff(6);
                        if dx==0&&dy==0;
                          target_body = nil;
                          i.dec_buff(6);
                          break;
                        else;
                          if target_body.is_a?(Fucker) && relate;
                            target_body.auto_skill=[\"$team_set.all?{|i| !i.event.moving?}\",[AutoBang.new,[para[1][0],para[1][1]]]];
                          elsif i.is_a?(Fucker) && i.ap>=i.get_ap_for_atk && (!target_body||relate);
                            i.cost_ap_for(1);
                            i.auto_skill=[\"$team_set.all?{|i| !i.event.moving?}\",[AutoBigBang.new,[para[1][0],para[1][1]]]];
                          else;
                            tskill = AutoT.new;
                            tskill.spec_effect=\"\" unless target_body;
                            i.auto_skill=[\"$team_set.all?{|i| !i.event.moving?}\",[tskill,[para[1][0],para[1][1]]]];
                          end
                          i.event.jump(dx,dy);
                          i.dec_buff(6);
                        end;
                      end;
                    end;"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class Relive < Skill
  
  def set_ui
    @icon = "relive"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 3
    @name = "操纵死尸"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 1
    @use_dis_max = 4
    @hotkey = 0x52
    @hurt_enemy = false
    @hurt_partner = false
    @hurt_p_dead = true
    @hurt_e_dead = true
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 1
    @sp_cost = 0
    @hp_cost = 100
    @ap_cost = 1
    @hp_damage = 60
    @sp_damage = 0
    @ap_damage = 0
    @buff = [[Ctrled,100]]
    @debuff = []
    @descr = "消耗1点行动力和100点生命力.\n复活并操控一具尸体为你作战.\n死尸在持续时间内不会死亡.\n死尸所受的伤害由施法者承担.\n持续2回合.\n施法距离:1-4."
  end
  
  def set_extra
    @spec_effect = "i.relive;i.hp=i.maxhp;i.ai=nil;i.team=@cur_actor.team;tempb << [true,0]"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = false
  end
  
end

class CallEleScene < Skill
  
  def set_ui
    @icon = "ele"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 4
    @name = "属性界面"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = 0x45
    @hurt_enemy = false
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 1
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "查看人物状态以及能力."
  end
  
  def set_other
    @use_in_battle = true
    @use_in_scene = true
  end
  
  def set_extra
    @spec_effect = "SceneManager.scene.call_ele_scene"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class CallGraScene < Skill
  
  def set_ui
    @icon = "gra"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 5
    @name = "画面设置"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = 0x47
    @hurt_enemy = false
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 1
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "调整画面效果.\n影响游戏性能."
  end
  
  def set_other
    @use_in_battle = true
    @use_in_scene = true
  end
  
  def set_extra
    @spec_effect = "SceneManager.scene.call_gra_scene"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class CallVoiScene < Skill
  
  def set_ui
    @icon = "voi"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 6
    @name = "声音设置"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = 0x56
    @hurt_enemy = false
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 1
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "调整声音效果."
  end
  
  def set_other
    @use_in_battle = true
    @use_in_scene = true
  end
  
  def set_extra
    @spec_effect = "SceneManager.scene.call_voi_scene"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class CallSaveScene < Skill
  
  def set_ui
    @icon = "sav"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 7
    @name = "存档界面"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = 0x53
    @hurt_enemy = false
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 1
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "进入存档界面.\n保存游戏进度."
  end
  
  def set_other
    @use_in_battle = true
    @use_in_scene = true
  end
  
  def set_extra
    @spec_effect = "if $map_battle;
                      @splink.show_tips(\"战斗中禁止存档\");
                    else;
                      SceneManager.scene.call_save_scene;
                    end;"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class CallMesScene < Skill
  
  def set_ui
    @icon = "mes"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 8
    @name = "获取公告"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = 0x4D
    @hurt_enemy = false
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 1
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "获取游戏最新消息."
  end
  
  def set_other
    @use_in_battle = true
    @use_in_scene = true
  end
  
  def set_extra
    @spec_effect = "SceneManager.scene.call_mes_scene"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class CallRetScene < Skill
  
  def set_ui
    @icon = "ret"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 9
    @name = "返回"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = 0x52
    @hurt_enemy = false
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 1
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "返回技能界面."
  end
  
  def set_other
    @use_in_battle = true
    @use_in_scene = true
  end
  
  def set_extra
    @spec_effect = "SceneManager.scene.call_ret_scene"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class AutoBang < Skill
  
  def set_ui
    @icon = "ret"
    @user_animation = 27
    @target_partner_animation = 0
    @target_enemy_animation = 48
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 10
    @name = "击杀"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = nil
    @hurt_enemy = true
    @hurt_partner = false
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "击杀一个敌人."
  end
  
  def set_other
    @use_in_battle = true
    @use_in_scene = true
  end
  
  def set_extra
    @spec_effect = "if @cur_actor.ap>=@cur_actor.get_ap_for_atk;
                      i.event.move_backward if i.event.passable?(i.x,i.y,10-i.event.direction);
                      if $random_center.rand(100)<[@cur_actor.get_atk-i.get_atk,50].min;
                        i.die;
                        @splink.show_text(\"Bingo!\",i.event,BINGO_COLOR,30);
                      else;
                        a=i.phy_damage(i.hp/10);
                        if a[0];
                          @splink.show_text(a[1],i.event,HP_COST_COLOR,20);
                        elsif a[1]<=1;
                          @splink.show_text(FAILD_ATTACK_TEXT[a[1]],i.event);
                        end;
                      end;
                      @cur_actor.cost_ap_for(1);
                    else;
                      @cur_actor.event.move_backward if @cur_actor.event.passable?(@cur_actor.x,@cur_actor.y,10-i.event.direction);
                      a=@cur_actor.phy_damage(i.hp/10);
                      if a[0];
                        @splink.show_text(a[1],@cur_actor.event,HP_COST_COLOR,20);
                      elsif a[1]<=1;
                        @splink.show_text(FAILD_ATTACK_TEXT[a[1]],i.event);
                      end;
                    end;"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class AutoT < Skill
  
  def set_ui
    @icon = "ret"
    @user_animation = 48
    @target_partner_animation = 48
    @target_enemy_animation = 48
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 11
    @name = "击杀"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = nil
    @hurt_enemy = true
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "攻击一个敌人."
  end
  
  def set_other
    @use_in_battle = true
    @use_in_scene = true
  end
  
  def set_extra
    @spec_effect = "i.event.move_backward if i.event.passable?(i.x,i.y,10-i.event.direction);
                    a=i.phy_damage(@cur_actor.hp/20);
                    if a[0];
                      @splink.show_text(a[1],i.event,HP_COST_COLOR,20);
                    elsif a[1]<=1;
                      @splink.show_text(FAILD_ATTACK_TEXT[a[1]],i.event);
                    end;
                    if i!=@cur_actor;
                      @cur_actor.event.set_direction(Fuc.mouse_dir_body(@cur_actor.event,i.event));
                      @cur_actor.event.move_backward if @cur_actor.event.passable?(@cur_actor.x,@cur_actor.y,10-i.event.direction);
                      a=@cur_actor.phy_damage(@cur_actor.hp/20);
                      if a[0];
                        @splink.show_text(a[1],@cur_actor.event,HP_COST_COLOR,20);
                      elsif a[1]<=1;
                        @splink.show_text(FAILD_ATTACK_TEXT[a[1]],i.event);
                      end;
                    end"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class AutoBigBang < Skill
  
  def set_ui
    @icon = "ret"
    @user_animation = 33
    @target_partner_animation = 0
    @target_enemy_animation = 48
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 12
    @name = "击杀"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = nil
    @hurt_enemy = true
    @hurt_partner = false
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[3]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "攻击一片敌人."
  end
  
  def set_other
    @use_in_battle = true
    @use_in_scene = true
  end
  
  def set_extra
    @spec_effect = "i.event.set_direction(Fuc.mouse_dir_body(i.event,@cur_actor.event));
                    i.event.move_backward if i.event.passable?(i.x,i.y,10-i.event.direction);
                    a=i.phy_damage(@cur_actor.hp/8);
                    if a[0];
                      @splink.show_text(a[1],i.event,HP_COST_COLOR,20);
                    elsif a[1]<=1;
                      @splink.show_text(FAILD_ATTACK_TEXT[a[1]],i.event);
                    end"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class PlaceEachOther < Skill
  
  def set_ui
    @icon = "f03"
    @user_animation = 3
    @target_partner_animation = 3
    @target_enemy_animation = 3
    @target_p_dead_animation = 3
    @target_e_dead_animation = 3
  end

  def set_ele
    @id = 13
    @name = "意念换位"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 1
    @use_dis_max = 6
    @hotkey = 0x45
    @hurt_enemy = true
    @hurt_partner = true
    @hurt_p_dead = true
    @hurt_e_dead = true
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 4
    @hp_cost = 0
    @ap_cost = 4
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "消耗4点怒气以及4点行动力.\n与一格内的战斗单位交换位置.\n对BOSS怪物无效.\n施法距离:1-6"
  end
  
  def set_extra
    @spec_effect = "if !i.boss;
                      @cur_actor.event.x,@cur_actor.event.y,i.event.x,i.event.y=i.event.x,i.event.y,@cur_actor.event.x,@cur_actor.event.y;
                      @cur_actor.event.real_x,@cur_actor.event.real_y,i.event.real_x,i.event.real_y=i.event.real_x,i.event.real_y,@cur_actor.event.real_x,@cur_actor.event.real_y;
                      set_view_pos(@cur_actor.x,@cur_actor.y);
                      tempb<<[true,0]
                    else;
                      tempb<<[false,21];
                    end"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = false
  end
  
end

class Baqiyemenbo < Skill
  
  def set_ui
    @icon = "f02"
    @user_animation = 10
    @target_partner_animation = 0
    @target_enemy_animation = 11
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 14
    @name = "意念穿透"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 1
    @use_dis_max = 1
    @hotkey = 0x57
    @hurt_enemy = true
    @hurt_partner = false
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0,0],[-1,1,3,1],[-2,2,5,1]] ,false]
    @hurt_maxnum = 0
    @sp_cost = 16
    @hp_cost = 0
    @ap_cost = 10
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "消耗16点怒气以及10点行动力.\n对面向视野内3格所有单位造成巨大伤害.\n同时有25%造成眩晕效果.\n若被攻击单位已经是眩晕状态.\n则造成更大伤害.\n施法距离:1"
  end
  
  def set_extra
    @spec_effect = "if i.in_buff(7);
                      a=i.mag_damage(150+@cur_actor.get_int);
                      if a[0];
                        @splink.show_text(a[1],i.event,HP_COST_COLOR,20);
                      elsif a[1]<=1;
                        @splink.show_text(FAILD_ATTACK_TEXT[a[1]],i.event);
                      end;
                    else;
                      a=i.mag_damage(80+@cur_actor.get_int);
                      if a[0];
                        @splink.show_text(a[1],i.event,HP_COST_COLOR,20);
                      elsif a[1]<=1;
                        @splink.show_text(FAILD_ATTACK_TEXT[a[1]],i.event);
                      end;
                    end;
                    if $random_center.rand(100)<25;
                      sm = ShutDown.new(@cur_actor);
                      i.add_buff(sm);
                      @splink.show_text(\"+\"+sm.name,i.event,SP_ADD_COLOR);
                    end"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = false
  end
  
end

class MagicBang < Skill
  
  attr_accessor :power_point
  
  def set_ui
    @icon = "f00"
    @user_animation = 8
    @target_partner_animation = 0
    @target_enemy_animation = 9
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 15
    @name = "意念爆发"
    @init_skill = true
    @use_req = "sp>=30&&ap>=15"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = 0x42
    @hurt_enemy = true
    @hurt_partner = false
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[6]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "消耗所有点怒气以及行动力.\n至少拥有30点怒气以及15点行动力.\n将消耗的怒气与行动力结合.\n产生20%结合数量的能量粒子.\n疯狂地将能量粒子扩散开击退所有敌人.\n每个能量粒子对周围所有敌人造成法力值25%的伤害.\n并有50%概率造成眩晕.\n作用范围:周身6格内,无需选取目标.\n\n副作用:\n3回合内使用者无法行动.\n此期间受到所有回复效果减半."
  end
  
  def set_extra
    @spec_effect = "if para[0].power_point==0;
                      para[0].power_point=(@cur_actor.ap+@cur_actor.sp)/5;
                      @cur_actor.add_buff(OverFuck.new(@cur_actor));
                      @cur_actor.ap = 0;
                      @cur_actor.sp = 0;
                    end;
                    i.event.set_direction(Fuc.mouse_dir_body(i.event,@cur_actor.event));
                    i.event.move_backward if i.event.passable?(i.x,i.y,10-i.event.direction);
                    a=i.mag_damage(para[0].power_point*@cur_actor.get_int/4);
                    if a[0];
                      @splink.show_text(a[1],i.event,HP_COST_COLOR,20);
                    elsif a[1]<=1;
                      @splink.show_text(FAILD_ATTACK_TEXT[a[1]],i.event);
                    end;
                    if $random_center.rand(100)<50;
                      sm = ShutDown.new(@cur_actor);
                      i.add_buff(sm);
                      @splink.show_text(\"+\"+sm.name,i.event,SP_ADD_COLOR);
                    end"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @power_point = 0
    @ignore_mag_det = false
  end
  
end

class Refraction < Skill

  def set_ui
    @icon = "f01"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 16
    @name = "奥术分散"
    @init_skill = false
    @uninit_buff = [RefractionBuff]
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = nil
    @hurt_enemy = true
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "自身强大的念力使敌人的进攻\n无法完全命中自己.\n每次自身受到任意伤害时.\n减少15%的伤害.\n并将这部分伤害转给周围的敌方单位.\n并且受到伤害如果大于最大生命\n的一半,超过得部分将被阻止.\n无视魔法免疫.\n作用范围:周身4格"
  end
  
  def set_extra
    @spec_effect = ""
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class Disturb < Skill

  def set_ui
    @icon = "f04"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 17
    @name = "奥术扰乱"
    @init_skill = false
    @uninit_buff = [DisturbBuff]
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = nil
    @hurt_enemy = true
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "由于修炼的特殊性.\n周围所有正常元素全被扰乱.\n使敌人很难正常行动.\n范围内敌方行动有10%的概率无效化.\n作用生效时,该单位损失\n最大行动力一半的行动力.\n作用范围为每15点法力一格."
  end
  
  def set_extra
    @spec_effect = ""
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class AttackDown < Skill
  
  def set_ui
    @icon = "m03"
    @user_animation = 28
    @target_partner_animation = 0
    @target_enemy_animation = 29
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 18
    @name = "重劈"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 1
    @use_dis_max = 1
    @hotkey = 0x46
    @hurt_enemy = true
    @hurt_partner = false
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0,0,1,4]] ,false]
    @hurt_maxnum = 0
    @sp_cost = 4
    @hp_cost = 0
    @ap_cost = 6
    @hp_damage = 40
    @sp_damage = 0
    @ap_damage = 0
    @buff = [[ShutDown,25]]
    @debuff = []
    @descr = "消耗4点怒气以及6点行动力.\n对前方单位造成伤害.\n同时有25%造成眩晕效果.\n施法距离:1"
  end
  
  def set_extra
    @spec_effect = "i.event.set_direction(Fuc.mouse_dir_body(i.event,@cur_actor.event));
                    i.event.move_backward if i.event.passable?(i.x,i.y,10-i.event.direction);"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = false
  end
  
end

class Blinkill < Skill
  
  def set_ui
    @icon = "m01"
    @user_animation = 30
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 19
    @name = "绞杀"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 1
    @use_dis_max = 5
    @hotkey = 0x57
    @hurt_enemy = false
    @hurt_partner = false
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_nothing = true
    @hurt_cant_move = true
    @hurt_area = [ [[-1,-1,3,3]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 10
    @hp_cost = 0
    @ap_cost = 6
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "消耗10点怒气和6点行动力.\n瞬间移动到指定位置.\n对途径所有周围敌方单位进行一次攻击.\n伤害等同于普通攻击.\n继承一切攻击效果.\n无视魔法免疫.\n施法距离:1-5\n\n特殊效果:\n若指定女主角为目标.\n两人交换位置.\n对敌方的攻击100%造成暴击."
  end
  
  def set_extra
    @spec_effect = "starget = $team_set.find{|eq| eq.is_a?(BeFucker)&&eq.x==para[1][0]&&eq.y==para[1][1]};
                    return [[false,13]] if (!$game_map.check_passage(*para[1],0xF)||$game_map.events_xy_nt(*para[1]).size>0)&&!starget;
                    @cur_actor.event.set_direction(Fuc.mouse_dir_body(@cur_actor,para[1]));
                    dy=para[1][1]-@actor.y;
                    dx=para[1][0]-@actor.x;
                    maxcont = [dy.abs,dx.abs].max;
                    npa = $syseting[:show_maparea];$syseting[:show_maparea]=false;
                    trectarr = []
                    [*1..maxcont].each do |fuckcont|;
                      tarx = dx/fuckcont;
                      tary = dy/fuckcont;
                      trectarr << [tarx-1,tary-1,3,3];
                    end;
                    $syseting[:show_maparea]=npa;
                    trectreal = Effect_Area.new([@actor.x,@actor.y],trectarr,false);
                    $team_set.each do |i|;
                      next if i.dead? || (i.team&@cur_actor.team).size>0 || !trectreal.include?(i.x,i.y);
                      if starget || $random_center.rand(100) < @cur_actor.bingo_rate;
                        Sound.bingo;
                        bingo_color = BINGO_COLOR;
                        bingo_size = 30;
                      else;
                        bingo_color = HP_COST_COLOR;
                        bingo_size = 20;
                      end;
                      i.event.animation_id = 31;
                      tempama = @cur_actor.get_atk;
                      tempama = tempama*@cur_actor.bingo_damage/100 if bingo_size > 20;
                      @cur_actor.buff.each{|cute| instance_eval(cute.atk_effect) rescue nil};
                      dama = i.phy_damage(tempama);
                      if dama[0];
                        if @cur_actor.hp_absorb_rate != 0 || @cur_actor.hp_absorb != 0;
                          a = @cur_actor.absorb_hp(dama[1]);
                          b = @cur_actor.absorb_hp_by_rate(i.hp);
                          c = -a[1]-b[1];
                          @splink.show_text(c.to_s,@cur_actor.event,HP_ADD_COLOR);
                        end;
                        if i.dmg_rebound !=0 || i.dmg_rebound_rate != 0;
                          a = @cur_actor.rebound_damage(dama[1],i.dmg_rebound_rate,i.dmg_rebound);
                          @splink.show_text(a[1].to_s,@cur_actor.event,HP_COST_COLOR) if a[0];
                        end;
                        @splink.show_text(dama[1].to_s,i.event,bingo_color,bingo_size);
                        @cur_actor.atk_buff.each do |buff|;
                          trate = buff[1].abs;
                          if $random_center.rand(100) < trate;
                            sm = buff[0].new;
                            i.add_buff(sm);
                            @splink.show_text("+"+sm.name,i.event,SP_ADD_COLOR) if buff[1]>0;
                          end;
                        end;
                        i.god_sp_damage(-2,true);
                      elsif dama[1]<=1;
                        @splink.show_text(FAILD_ATTACK_TEXT[dama[1]],i.event);
                      end;
                      @splink.show_value(i.hp*100/i.maxhp,i.event);
                    end;
                    if starget;
                      @cur_actor.event.x,starget.event.x = starget.event.x,@cur_actor.event.x;
                      @cur_actor.event.y,starget.event.y = starget.event.y,@cur_actor.event.y;
                      @cur_actor.event.real_x,starget.event.real_x = starget.event.real_x,@cur_actor.event.real_x;
                      @cur_actor.event.real_y,starget.event.real_y = starget.event.real_y,@cur_actor.event.real_y;
                    else;
                      @cur_actor.event.x=@cur_actor.event.real_x=para[1][0];
                      @cur_actor.event.y=@cur_actor.event.real_y=para[1][1];
                    end
                    set_view_pos(@cur_actor.x,@cur_actor.y);
                    @actor.animation_id = para[0].user_animation
                    @cur_actor.cost_ap_for(3,para[0].ap_cost)
                    @cur_actor.god_sp_damage(para[0].sp_cost,true)
                    @cur_actor.god_damage(para[0].hp_cost,true)
                    return [[true,0]];"
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class SoulSword < Skill
  
  def set_ui
    @icon = "m02"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 49
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 20
    @name = "灵魂之刃"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 1
    @use_dis_max = 1
    @hotkey = 0x45
    @hurt_enemy = true
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,false]
    @hurt_maxnum = 0
    @sp_cost = 10
    @hp_cost = 0
    @ap_cost = 10
    @hp_damage = 1
    @sp_damage = 0
    @ap_damage = 0
    @buff = [[SoulSwordBuff,100]]
    @debuff = []
    @descr = "消耗10点怒气以及10点行动力.\n将剑附上灵魂的力量刺入敌人体内.\n将使用者和被施法者连接起来.\n效果时间内.\n角色所受伤害以及回复全部转为伤害给与被施法者.\n并且只能对一个敌人生效.\n持续:2回合.\n施法距离:1\n\n特殊效果:\n若目标为友方单位.\n将所受伤害以及回复全部转为回复给与该单位."
  end
  
  def set_extra
    @spec_effect = ""
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = false
  end
  
end

class BreakSelf < Skill
  
  def set_ui
    @icon = "m05"
    @user_animation = 34
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 21
    @name = "挣脱"
    @init_skill = true
    @use_req = "true"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = 0x42
    @hurt_enemy = false
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 0
    @hp_cost = 60
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = [[BreakSelfBuff,-100]]
    @debuff = []
    @descr = "消耗60点生命.\n一定概率净化自身所有状态.\n概率至高为60%.\n每多一个可清除状态概率减少10%.\n概率至少20%.\n无需选择目标,直接生效."
  end
  
  def set_extra
    @spec_effect = ""
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = false
  end
  
end

class MultAttack < Skill

  def set_ui
    @icon = "m06"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 22
    @name = "连斩"
    @init_skill = false
    @uninit_buff = [MultAttackBuff]
    @use_req = "false"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = nil
    @hurt_enemy = true
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "每次攻击有40%在攻击完毕之后继续发动一次攻击.\n并且能继续触发连斩.\n此效果不能被普通攻击以外触发."
  end
  
  def set_extra
    @spec_effect = ""
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end

class Kingdom < Skill

  def set_ui
    @icon = "relive"
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
    @target_p_dead_animation = 0
    @target_e_dead_animation = 0
  end

  def set_ele
    @id = 23
    @name = "存在"
    @init_skill = false
    @uninit_buff = [KingdomBuff]
    @use_req = "false"
    @use_dis_min = 0
    @use_dis_max = 0
    @hotkey = nil
    @hurt_enemy = true
    @hurt_partner = true
    @hurt_p_dead = false
    @hurt_e_dead = false
    @hurt_area = [ [[0]] ,true]
    @hurt_maxnum = 0
    @sp_cost = 0
    @hp_cost = 0
    @ap_cost = 0
    @hp_damage = 0
    @sp_damage = 0
    @ap_damage = 0
    @buff = []
    @debuff = []
    @descr = "有%25的概率无效任何伤害.\n\n特殊效果:\n当受到致命伤害时免疫此伤害.\n接下来三回合内阻止一切致命伤害.\n此效果一场战斗最多出现一次."
  end
  
  def set_extra
    @spec_effect = ""
    @sp_cost_rate = 0
    @hp_cost_rate = 0
    @ap_cost_rate = 0
    @level = 0
    @hp_damage_add = "skill.level*100"
    @sp_damage_add = "skill.level*50"
    @ap_damage_add = "0"
    @ignore_mag_det = true
  end
  
end