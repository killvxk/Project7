#include "RGSSMouse.h"

int RGSSMouse::mouse_x = 0;
int RGSSMouse::mouse_y = 0;
bool RGSSMouse::mouse_ldown;
bool RGSSMouse::mouse_rdown;
bool RGSSMouse::mouse_mdown;
bool RGSSMouse::mouse_lup;
bool RGSSMouse::mouse_rup;
bool RGSSMouse::mouse_mup;

bool RGSSMouse::mouse_ldblc;
bool RGSSMouse::mouse_rdblc;
bool RGSSMouse::mouse_mdblc;
bool RGSSMouse::mouse_ltoggle;
bool RGSSMouse::mouse_rtoggle;
bool RGSSMouse::mouse_mtoggle;
bool RGSSMouse::mouse_moved;
bool RGSSMouse::mouse_lpress;
bool RGSSMouse::mouse_rpress;
bool RGSSMouse::mouse_mpress;
LONG RGSSMouse::dwNewLong;
int RGSSMouse::mouse_wheel;

int RGSSMouse::pos;
#ifdef HookerTest
extern FILE *LOG;
#endif
LRESULT WINAPI RGSSMouse::MouseWndProcHook(HWND hWnd,UINT Msg,WPARAM wParam,LPARAM IParam)
{
#ifdef HookerTest
	fprintf(LOG,"MouseWndProcHook:%d\n\r",pos);fflush(LOG);
#endif	
	if (!dwNewLong)
	    dwNewLong = (LONG)CopyIcon(GetCursor());


	if (Msg==WM_LBUTTONDOWN)
	{
		mouse_ldown=true;
		mouse_lpress=true;
		mouse_ltoggle=!mouse_ltoggle;
	}
	if (Msg==WM_RBUTTONDOWN)
	{
		mouse_rdown=true;
		mouse_rpress=true;
		mouse_rtoggle=!mouse_rtoggle;
	}
	if (Msg==WM_MBUTTONDOWN)
	{
		mouse_mdown=true;
		mouse_mpress=true;
		mouse_mtoggle=!mouse_mtoggle;
	}
	if (Msg==WM_LBUTTONUP)
	{
		mouse_ldown=false;
		mouse_lup=true;
		mouse_lpress=false;
	}
	if (Msg==WM_RBUTTONUP)
	{
		mouse_rdown=false;
		mouse_rup=true;
		mouse_rpress=false;
	}
	if (Msg==WM_MBUTTONUP)
	{
		mouse_mdown=false;
		mouse_mup=true;
		mouse_mpress=false;
	}
	if (Msg==WM_LBUTTONDBLCLK)
	{
		mouse_ldblc = true;
	}
	if (Msg==WM_RBUTTONDBLCLK)
	{
		mouse_rdblc = true;
	}
	if (Msg==WM_MBUTTONDBLCLK)
	{
		mouse_mdblc = true;
	}
	if (Msg==WM_MOUSEMOVE)
	{
		mouse_x = IParam&0xffff;
		mouse_y = IParam>>16;
		mouse_moved = true;
	}
	if (Msg==WM_MOUSEWHEEL)
	{
		mouse_wheel += GET_WHEEL_DELTA_WPARAM(wParam);
	}
	//if (Msg == WM_ACTIVATEAPP)
	//	return 0;
	return CallNext(hWnd,Msg,wParam,IParam,pos);
}
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::MouseUpdate(RGSS3Runtime::VALUE obj)
{
	mouse_ldown = mouse_rdown = mouse_mdown = false;
	mouse_lup = mouse_rup = mouse_mup = false;
	mouse_ldblc = mouse_rdblc = mouse_mdblc = false;
	mouse_moved = false;
	mouse_wheel = 0;
	return RGSS3Runtime::Qnil;
}
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_get_x(RGSS3Runtime::VALUE obj)
{
	return runtime->INT2FIX(mouse_x); //???�ᵼ��APPCRASH��
}
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_get_y(RGSS3Runtime::VALUE obj)
{
	return runtime->INT2FIX(mouse_y);
}
/*
#     Mouse.up?(key)
#       ��갴���Ƿ���"�ɿ�"��˲��
#       ����keyȡֵ(1:��� 2:�Ҽ� 4:�м�),�����������,��ʾ��������,��ͬ
*/

#define RBOOL(val) (val)?runtime->Qtrue:runtime->Qfalse;

RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_up(int argc, RGSS3Runtime::VALUE *argv,RGSS3Runtime::VALUE obj){
	return RBOOL(((mouse_lup | ((mouse_rup) << 1) | ((mouse_mup) << 2)) & (argc == 0 ? 7 : runtime->FIX2INT(argv[0]))) != 0);
}
/*
#     Mouse.down?(key)
#       ��갴���Ƿ���"����"��˲��
*/
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_down(int argc, RGSS3Runtime::VALUE *argv, RGSS3Runtime::VALUE obj){
	return RBOOL(((mouse_ldown | (mouse_rdown << 1) | (mouse_mdown << 2)) & (argc == 0 ? 7 : runtime->FIX2INT(argv[0]))) != 0);
}
/*
#     Mouse.click?(key)
#       ��갴������,�ű���,���ж�down?
*/
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_click(int argc, RGSS3Runtime::VALUE *argv, RGSS3Runtime::VALUE obj){
	return RBOOL(((mouse_ldown | (mouse_rdown << 1) | (mouse_mdown << 2)) & (argc == 0 ? 7 : runtime->FIX2INT(argv[0]))) != 0);
}
/*
#     Mouse.dbl_clk?(key)
#       ��갴��˫��
*/
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_dbl_clk(int argc, RGSS3Runtime::VALUE *argv, RGSS3Runtime::VALUE obj){
	return RBOOL(((mouse_ldblc | (mouse_rdblc << 1) | (mouse_mdblc << 2)) & (argc == 0 ? 7 : runtime->FIX2INT(argv[0]))) != 0);
}
/*
#     Mouse.press?(key)
#       ��갴���Ƿ���"����"��״̬
*/
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_press(int argc, RGSS3Runtime::VALUE *argv, RGSS3Runtime::VALUE obj){
	return RBOOL(((mouse_lpress | (mouse_rpress << 1) | (mouse_mpress << 2)) & (argc == 0 ? 7 : runtime->FIX2INT(argv[0]))) != 0);
}
/*
#     Mouse.toggle?(key)
#       ��갴���Ĵ���״̬(�ڿ��͹�֮���л�)
*/
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_toggle(int argc, RGSS3Runtime::VALUE *argv, RGSS3Runtime::VALUE obj){
	return RBOOL(((mouse_ltoggle | (mouse_rtoggle << 1) | (mouse_mtoggle << 2)) & (argc == 0 ? 7 : runtime->FIX2INT(argv[0]))) != 0);
}
/*
#     Mouse.scroll
#       ���������ֵĹ���ֵ.��ֵ��ʾ��ǰ,��ֵ��ʾ���,���ʾδ��������
*/
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_scroll(RGSS3Runtime::VALUE obj){
	return runtime->INT2FIX(mouse_wheel);
}
/*
#     Mouse.move?
#       �ж�����Ƿ��ƶ�
*/
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_move(RGSS3Runtime::VALUE obj){
	return RBOOL(mouse_moved);
}
/*
#     Mouse.set_pos(x,y)
#       ָ���������,����ƶ���������
*/
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_set_pos(RGSS3Runtime::VALUE obj,RGSS3Runtime::VALUE x,RGSS3Runtime::VALUE y){
	POINT point;
	ClientToScreen(gameplayer->g_hWnd, &point);
	return RBOOL(SetCursorPos(point.x + runtime->FIX2INT(x), point.y + runtime->FIX2INT(y)));
}
/*
#     Mouse.set_cursor(file)
#       �ı䵱ǰ���Ĺ����ʽ.����fileΪ����ļ���(·��������ģ��ָ��)
#       �������Ϊnil����ָ������ļ������ڵ�,�����ش���,����겻�ɼ�
*/
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_set_cursor(RGSS3Runtime::VALUE obj,RGSS3Runtime::VALUE mouse){

	return RBOOL(SetClassLongA(gameplayer->g_hWnd, -12, (LONG)LoadCursorFromFileA(runtime->rb_string_value_ptr(&mouse))));
}
/*
#     Mouse.sys_cursor
#       ��ԭ��ϵͳĬ�Ϲ��
*/
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_sys_cursor(RGSS3Runtime::VALUE obj){
	return RBOOL(SetClassLongA(gameplayer->g_hWnd, -12, dwNewLong));
}
/*
#     Mouse.clip(x,y,width,height)
#       �����������ָ������Χ��
#       ʡ�Բ���ʱ,����������
*/
RGSS3Runtime::VALUE RUBYCALL RGSSMouse::dm_clip(int argc, RGSS3Runtime::VALUE *argv,RGSS3Runtime::VALUE obj){
	if (argc==0)
	{
		return RBOOL(ClipCursor(0));
	}
	else if (argc==4)
	{
		POINT point;
		ClientToScreen(gameplayer->g_hWnd, &point);

		RECT rect;
		rect.left += point.x + runtime->FIX2INT(argv[0]);
		rect.top += point.y + runtime->FIX2INT(argv[1]);
		rect.right = rect.left + runtime->FIX2INT(argv[2]);
		rect.bottom = rect.top + runtime->FIX2INT(argv[3]);
		return RBOOL(ClipCursor(&rect));
	}
	return RGSS3Runtime::Qnil;
}
#undef RBOOL
void RGSSMouse::InitRuby()
{
	//DBLCTIME =   GetDoubleClickTime()*60.0/1000.0;
	RGSS3Runtime::VALUE rbcMouse = runtime->rb_define_module("CMouse");
	runtime->rb_define_module_function(rbcMouse,"update",(RGSS3Runtime::RubyFunc)MouseUpdate,0);
	runtime->rb_define_module_function(rbcMouse,"x",(RGSS3Runtime::RubyFunc)dm_get_x,0);
	runtime->rb_define_module_function(rbcMouse,"y",(RGSS3Runtime::RubyFunc)dm_get_y,0);
	runtime->rb_define_module_function(rbcMouse,"up?",(RGSS3Runtime::RubyFunc)dm_up,-1);
	runtime->rb_define_module_function(rbcMouse,"down?",(RGSS3Runtime::RubyFunc)dm_down,-1);
	runtime->rb_define_module_function(rbcMouse,"click?",(RGSS3Runtime::RubyFunc)dm_click,-1);
	runtime->rb_define_module_function(rbcMouse,"dbl_clk?",(RGSS3Runtime::RubyFunc)dm_dbl_clk,-1);
	runtime->rb_define_module_function(rbcMouse,"press?",(RGSS3Runtime::RubyFunc)dm_press,-1);
	runtime->rb_define_module_function(rbcMouse,"toggle?",(RGSS3Runtime::RubyFunc)dm_toggle,-1);
	runtime->rb_define_module_function(rbcMouse,"scroll",(RGSS3Runtime::RubyFunc)dm_scroll,0);
	runtime->rb_define_module_function(rbcMouse,"move",(RGSS3Runtime::RubyFunc)dm_move,0);
	runtime->rb_define_module_function(rbcMouse,"set_pos",(RGSS3Runtime::RubyFunc)dm_set_pos,2);
	runtime->rb_define_module_function(rbcMouse,"set_cursor",(RGSS3Runtime::RubyFunc)dm_set_cursor,1);
	runtime->rb_define_module_function(rbcMouse,"sys_cursor",(RGSS3Runtime::RubyFunc)dm_sys_cursor,0);
	runtime->rb_define_module_function(rbcMouse,"clip",(RGSS3Runtime::RubyFunc)dm_clip,-1);
}
bool RGSSMouse::Install()
{
	pos = SetupWndHook((WNDPROC)MouseWndProcHook);
	return true;
}


RGSSMouse::RGSSMouse(void)
{
}
RGSSMouse::~RGSSMouse(void)
{
}
