﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.Drawing;
using System.ComponentModel;

namespace LynnEditor
{
    public class LynnListbox : System.Windows.Forms.ListBox
    {
        private Color backColor = Color.White;
        private Color backColorAlt = Color.FromArgb(228, 236, 242);
        private Color foreColor = Color.Black;
        private Color selectedColor1 = Color.FromArgb(0, 100, 200);
        private Color selectedColor2 = Color.FromArgb(0, 158, 247);
        private Color selectedForeColor = Color.White;
        private StringFormat stringFormat;

        public LynnListbox()
            : base()
        {
            base.DrawMode = DrawMode.OwnerDrawFixed;
            this.IntegralHeight = false;

            stringFormat = new StringFormat(StringFormatFlags.NoClip);
            stringFormat.LineAlignment = StringAlignment.Center;
            stringFormat.Trimming = StringTrimming.EllipsisCharacter;
            stringFormat.HotkeyPrefix = System.Drawing.Text.HotkeyPrefix.None;
            OnFontChanged(EventArgs.Empty);
        }

        //override on

        protected override void OnDrawItem(DrawItemEventArgs e)
        {
            Brush backalt = new SolidBrush(backColorAlt);
            Brush back = new SolidBrush(backColor);
            if (e.Index >= 0 && this.Items.Count > 0)
            {
                string s = this.Items[e.Index].ToString() + "　";
                Brush fore;
                if ((e.State & DrawItemState.Selected) != DrawItemState.None)
                {
                    fore = new SolidBrush(selectedForeColor);

                    Rectangle bound = new Rectangle(e.Bounds.X, e.Bounds.Y, e.Bounds.Width, e.Bounds.Height - 1);
                    Rectangle bound2 = new Rectangle(e.Bounds.X, e.Bounds.Y + e.Bounds.Height - 1, e.Bounds.Width, 1);
                    e.Graphics.FillRectangle(new System.Drawing.Drawing2D.LinearGradientBrush(bound, this.selectedColor1, this.selectedColor2, 90), bound);
                    e.Graphics.FillRectangle(new SolidBrush(selectedColor1), bound2);
                }
                else
                {

                    fore = new SolidBrush(foreColor);

                    e.Graphics.FillRectangle(e.Index % 2 == 0 ? back : backalt, e.Bounds);
                }

                e.Graphics.DrawString(s, this.Font, fore, e.Bounds, stringFormat);
            }
            if (e.Index == this.Items.Count - 1)
            {
                int count = Math.Max(this.ClientSize.Height / this.ItemHeight - this.Items.Count, 0) + 1;
                for (int i = this.Items.Count; i < this.Items.Count + count; i++)
                {
                    e.Graphics.FillRectangle(i % 2 == 0 ? back : backalt, new Rectangle(e.Bounds.Left, e.Bounds.Top + (i - this.Items.Count + 1) * this.ItemHeight, e.Bounds.Width, this.ItemHeight));
                }
            }
        }

        [EditorBrowsable(EditorBrowsableState.Never), Browsable(false)]
        public new bool MultiColumn
        {
            get { return false; }
            set { }
        } 

        [EditorBrowsable(EditorBrowsableState.Never), Browsable(false)]
        public new DrawMode DrawMode
        {
            get { return base.DrawMode; }
            set { }
        }

        protected override void OnResize(EventArgs e)
        {
            this.Refresh();
            base.OnResize(e);
        }

        protected override void OnFontChanged(EventArgs e)
        {
            this.ItemHeight = Math.Min(Math.Max(Font.Height, 16), 255);
            base.OnFontChanged(e);
        }
    }
}