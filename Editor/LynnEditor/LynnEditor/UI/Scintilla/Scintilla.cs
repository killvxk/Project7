﻿using System;
using System.Collections.Generic;
using System.Text;

namespace LynnEditor.UI
{
    public class Scintilla : ScintillaNet.Scintilla
    {
        public Scintilla()
        {
            this.Font = new System.Drawing.Font("雅黑宋体", 12);
        }
    }
}
