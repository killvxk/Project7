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
	struct MouseState
	{
		int mouse_x;
		int mouse_y;
		bool mouse_ldown;
		bool mouse_rdown;
		bool mouse_mdown;
		bool mouse_lup;
		bool mouse_rup;
		bool mouse_mup;

		bool mouse_ldblc;
		bool mouse_rdblc;
		bool mouse_mdblc;
		bool mouse_ltoggle;
		bool mouse_rtoggle;
		bool mouse_mtoggle;
		bool mouse_moved;
		int mouse_wheel;
	};
	static LONG dwNewLong;
	static const int MOUSELKEY=1;
	static const int MOUSERKEY=2;
	static const int MOUSEMKEY=4;
	static bool mouse_lpress;
	static bool mouse_rpress;
	static bool mouse_mpress;
	static double DBLCTIME;
	static int pos;
	static void InitRuby();

	static MouseState* ms;
	static MouseState* oms;
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