﻿using System;
using System.Collections.Generic;

using System.Text;

namespace LynnEditor
{
    public class ScriptFile : AbstractFile, IFindAllProvider
    {
        public string Code;

        public ScriptFile(string filename) : base(filename)
        {
            this.Code = System.IO.File.ReadAllText(filename, Encoding.UTF8);
        }

        public ScriptFile(string filename, string code)
            : base(filename)
        {
            this.Code = code;
        }

        protected override void Save()
        {
            System.IO.File.WriteAllText(this.filename, this.Code, Encoding.UTF8);
        }

        public override AbstractEditor CreateEditor()
        {
            return new ScriptEditor(this);
        }

        public NavPoint[] FindAll(string Keyword)
        {
            if (this.Editor != null)
                this.Editor.Commit();

            var lines = this.Code.Split(new string[] { System.Environment.NewLine }, StringSplitOptions.None);
            var result = new List<NavPoint>();

            for (int i = 0; i < lines.Length; i++)
            {
                if (lines[i].IndexOf(Keyword, 0) >= 0)
                    result.Add(new ScriptFileNavPoint(this.filename) { LineNo = i, LineText = lines[i]});
            }

            return result.ToArray();
        }

        public override void Goto(NavPoint pt)
        {
            ScriptFileNavPoint s = pt as ScriptFileNavPoint;
            if (s != null)
            {
                this.ShowEditor();
                try
                {
                    (this.editor as ScriptEditor).editor.Lines[s.LineNo].Goto();
                }
                catch { }
                return;
            }
            base.Goto(pt);
        }
    }

    public class ScriptFileNavPoint : NavPoint
    {
        public int LineNo;
        public string LineText;

        public ScriptFileNavPoint(string id) : base(id) { }

        public override string ToString()
        {
            return String.Format("{0}:{1}: {2}", this.FileIdentify, this.LineNo, this.LineText);
        }
    }
}
