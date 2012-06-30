﻿using System;
using System.Collections.Generic;

using System.Text;

namespace LynnEditor
{
    public abstract class AbstractFile
    {
        public string filename;
        protected AbstractEditor editor;
        protected bool isDirty = false;
        protected bool pendingDelete = false;

        public AbstractFile(string filename)
        {
            this.filename = filename;
        }

        protected abstract void Save();

        public void Commit()
        {
            if (this.editor != null)
                this.editor.Commit();

            if (this.pendingDelete == true)
            {
                System.IO.File.Delete(this.filename);
                this.isDirty = false;
                return;
            }

            Save();
            this.isDirty = false;
        }

        public void PendingDelete()
        {
            this.pendingDelete = true;

            if (this.editor != null)
            {
                this.editor.Commit();
                this.editor.Close();
            }

            this.MakeDirty();
        }

        public abstract AbstractEditor CreateEditor();

        public override string ToString()
        {
            return System.IO.Path.GetFileNameWithoutExtension(this.filename);
        }

        public void ShowEditor()
        {
            if (this.editor == null)
                this.editor = CreateEditor();

            if (this.editor.IsDisposed)
                this.editor = CreateEditor();

            if (this.editor.Visible == true)
            {
                this.editor.Activate();
                return;
            }

            this.editor.Show(Workbench.Instance.DockPanel);
        }

        public AbstractEditor Editor
        {
            get
            {
                if (this.editor == null)
                    return null;

                if (this.editor.IsDisposed)
                    return null;

                return this.editor;
            }
        }

        protected bool IsDirty
        {
            get { return this.isDirty; }
            set {
                if (this.isDirty == false && value == true)
                {
                    this.isDirty = true;
                    Workbench.Instance.AddPendingChange(this);
                }
                else if (value == false)
                    this.isDirty = false;
            }
        }

        public void MakeDirty()
        {
            this.IsDirty = true;
        }
    }
}
