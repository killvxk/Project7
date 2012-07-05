#pragma once
#include "abstractrgssextension.h"
#include "RGSS3Runtime.h"

class RGSSMouse :
	public AbstractRGSSExtension
{
public:
	RGSSMouse();//(RGSS3Runtime *_runtime,GamePlayer * _gameplayer);
	static bool Install();
	~RGSSMouse(void);
	static RGSS3Runtime::VALUE RUBYCALL MouseUpdate(RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_get_x(RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_get_y(RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_up(int argc, RGSS3Runtime::VALUE *argv,RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_down(int argc, RGSS3Runtime::VALUE *argv,RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_click(int argc, RGSS3Runtime::VALUE *argv, RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_dbl_clk(int argc, RGSS3Runtime::VALUE *argv, RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_press(int argc, RGSS3Runtime::VALUE *argv, RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_toggle(int argc, RGSS3Runtime::VALUE *argv, RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_scroll(RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_move(RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_set_pos(RGSS3Runtime::VALUE obj,RGSS3Runtime::VALUE x,RGSS3Runtime::VALUE y);
	static RGSS3Runtime::VALUE RUBYCALL dm_set_cursor(RGSS3Runtime::VALUE obj,RGSS3Runtime::VALUE mouse);
	static RGSS3Runtime::VALUE RUBYCALL dm_sys_cursor(RGSS3Runtime::VALUE obj);
	static RGSS3Runtime::VALUE RUBYCALL dm_clip(int argc, RGSS3Runtime::VALUE *argv,RGSS3Runtime::VALUE obj);
	static LRESULT WINAPI MouseWndProcHook(HWND hWnd,UINT Msg,WPARAM wParam,LPARAM IParam);
	static int mouse_x;
	static int mouse_y;
	static bool mouse_ldown;
	static bool mouse_rdown;
	static bool mouse_mdown;
	static bool mouse_lup;
	static bool mouse_rup;
	static bool mouse_mup;
	static bool mouse_lpress;
	static bool mouse_rpress;
	static bool mouse_mpress;
	static bool mouse_ldblc;
	static bool mouse_rdblc;
	static bool mouse_mdblc;
	static bool mouse_ltoggle;
	static bool mouse_rtoggle;
	static bool mouse_mtoggle;
	static bool mouse_moved;
	static int mouse_wheel;
	static LONG dwNewLong;
	static const int MOUSELKEY=1;
	static const int MOUSERKEY=2;
	static const int MOUSEMKEY=4;
	static double DBLCTIME;
	static int pos;
	static void InitRuby();
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