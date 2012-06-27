#pragma once
#include "abstractrgssextension.h"
#include "RGSS3Runtime.h"

class RGSSMouse :
	public AbstractRGSSExtension
{
public:
	RGSSMouse(RGSS3Runtime *_runtime,GamePlayer * _gameplayer);
	~RGSSMouse(void);
	static RGSS3Runtime::VALUE RUBYCALL MouseUpdate(RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_get_x(RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_get_y(RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_up(RGSS3Runtime::VALUE obj,RGSS3Runtime::VALUE key);
	static RGSS3Runtime::VALUE RUBYCALL dm_down(RGSS3Runtime::VALUE obj,RGSS3Runtime::VALUE key);
	static RGSS3Runtime::VALUE RUBYCALL dm_click(RGSS3Runtime::VALUE obj,RGSS3Runtime::VALUE key);
	static RGSS3Runtime::VALUE RUBYCALL dm_dbl_clk(RGSS3Runtime::VALUE obj,RGSS3Runtime::VALUE key);
	static RGSS3Runtime::VALUE RUBYCALL dm_press(RGSS3Runtime::VALUE obj,RGSS3Runtime::VALUE key);
	static RGSS3Runtime::VALUE RUBYCALL dm_toggle(RGSS3Runtime::VALUE obj,RGSS3Runtime::VALUE key);
	static RGSS3Runtime::VALUE RUBYCALL dm_scroll(RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_move(RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_set_pos(RGSS3Runtime::VALUE obj,RGSS3Runtime::VALUE x,RGSS3Runtime::VALUE y);
	static RGSS3Runtime::VALUE RUBYCALL dm_set_cursor(RGSS3Runtime::VALUE obj,RGSS3Runtime::VALUE mouse);
	static RGSS3Runtime::VALUE RUBYCALL dm_sys_cursor(RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_clip(int argc, RGSS3Runtime::VALUE *argv,RGSS3Runtime::VALUE obj);
};

/*
#     Mouse.pos
#       �ṩ�������,����ֵ�Ǹ�����,��ʽΪ[x,y]
#     Mouse.area?(rect)
#       �ж�����Ƿ��ڲ���rect��Χ��
#     Mouse.up?(key)
#       ��갴���Ƿ���"�ɿ�"��˲��
#       ����keyȡֵ(1:��� 2:�Ҽ� 4:�м�),�����������,��ʾ��������,��ͬ
#     Mouse.down?(key)
#       ��갴���Ƿ���"����"��˲��
#     Mouse.click?(key)
#       ��갴������,�ű���,���ж�down?
#     Mouse.dbl_clk?(key)
#       ��갴��˫��
#     Mouse.press?(key)
#       ��갴���Ƿ���"����"��״̬
#     Mouse.toggle?(key)
#       ��갴���Ĵ���״̬(�ڿ��͹�֮���л�)
#     Mouse.scroll
#       ���������ֵĹ���ֵ.��ֵ��ʾ��ǰ,��ֵ��ʾ���,���ʾδ��������
#     Mouse.move?
#       �ж�����Ƿ��ƶ�
#     Mouse.set_pos(x,y)
#       ָ���������,����ƶ���������
#     Mouse.set_cursor(file)
#       �ı䵱ǰ���Ĺ����ʽ.����fileΪ����ļ���(·��������ģ��ָ��)
#       �������Ϊnil����ָ������ļ������ڵ�,�����ش���,����겻�ɼ�
#     Mouse.sys_cursor
#       ��ԭ��ϵͳĬ�Ϲ��
#     Mouse.clip(x,y,width,height)
#       �����������ָ������Χ��
#       ʡ�Բ���ʱ,����������
*/
extern RGSSMouse *cRGSSMouse;