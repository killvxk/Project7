﻿class FuckEachOther < Skill
  
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
    @descr = "需要4点怒气以及4点行动力催动.\n选中一个友方单位或是智力低于自己的敌人.\n向指定的目标格抛出.\n若指定目标格为空地,则无事.\n若指定目标格为敌人或友军.\n行动力不足以攻击的一方受到伤害.\n伤害与被投掷者生命关.\n施法距离:1-6\n\n特殊效果:\n若投掷男主角.\n目标区域伤害为3格范围.\n若投掷目标向男主角.\n则有一定概率秒杀被投掷单位."
  end
  
  def set_extra
    @spec_effect = "if !i.is_a?(Fucker) && i.int>=@cur_actor.int;
                      tempb << [false,21];
                    else;
                      tempb << [true,0];
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
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
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
                      if $random_center.rand(100)<20;
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
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
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
                      @cur_actor.event.set_direction(10-i.event.direction);
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
    @user_animation = 0
    @target_partner_animation = 0
    @target_enemy_animation = 0
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