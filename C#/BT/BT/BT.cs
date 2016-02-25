/********************************************************************
    created:    2016/02/25
    created:    2016/2/25  19:52
    filename:   BT.cs
    author:     郑辉

    purpose:    bt树简单基类 包含CompositeNode,DecoratorNode,ActionNode，ConditionNode
*********************************************************************/
using System;
using System.Collections.Generic;
using System.Linq;
using NF.Entity;

namespace NF.BT
{
    /// <summary>
    /// 接口
    /// </summary>
    public interface IBTreeNode
    {
        /// <summary>
        /// 操作
        /// </summary>
        /// <param name="theOwner"></param>
        /// <returns></returns>
        bool Processs(EntityParent theOwner);
    }

    /// <summary>
    /// 根结点
    /// </summary>
    public class BTreeRoot : IBTreeNode
    {
        IBTreeNode mRoot = null;

        public virtual bool Processs(EntityParent theOwner)
        {
            if(mRoot != null)
                return mRoot.Processs(theOwner);
            else
                return true;
        }


        /// <summary>
        /// 设置根节点
        /// </summary>
        /// <param name="root"></param>
        public void SetRoot(IBTreeNode root)
        {
            mRoot = root;
        }
    }


    /// <summary>
    /// 复合结点,Selector,Sequence,Parallel
    /// </summary>
    public class CompositeNode : IBTreeNode
    {
        protected List<IBTreeNode> mChildren = new List<IBTreeNode>();

        /// <summary>
        /// 操作，由子树
        /// </summary>
        /// <param name="theOwner"></param>
        /// <returns></returns>
        public virtual bool Processs(EntityParent theOwner)
        {
            return true;
        }

        /// <summary>
        /// 添加子节点
        /// </summary>
        /// <param name="node"></param>
        public virtual void AddChild(IBTreeNode node)
        {
            mChildren.Add(node);
        }

        /// <summary>
        /// 删除子节点
        /// </summary>
        /// <param name="node"></param>
        public virtual void DelChild(IBTreeNode node)
        {
            mChildren.Remove(node);
        }

        /// <summary>
        /// 清楚所有节点
        /// </summary>
        public virtual void ClearChildren()
        {
            mChildren.Clear();
        }
    }


    /// <summary>
    /// 装饰结点，一般只有一个结点额外添加一些功能，比如让子task一直运行直到其返回某个运行状态值，或者将task的返回值取反等等
    /// </summary>
    public class DecoratorNode : IBTreeNode
    {
        IBTreeNode mNode = null;

        /// <summary>
        /// 操作
        /// </summary>
        /// <param name="theOwner"></param>
        /// <returns></returns>
        public virtual  bool Processs(EntityParent theOwner)
        {
            if(mNode != null)
                return mNode.Processs(theOwner);
            else
                return true;
        }

        /// <summary>
        /// 设置结点
        /// </summary>
        /// <param name="node"></param>
        public virtual void SetNode(IBTreeNode node)
        {
            mNode = node;
        }
    }


    /// <summary>
    /// 动作操作结点
    /// </summary>
    public class ActionNode : IBTreeNode
    {
        public virtual bool Processs(EntityParent theOwner)
        {
            return false;
        }
    }

    /// <summary>
    /// 条件结点
    /// </summary>
    public class ConditionNode : IBTreeNode
    {
        public virtual bool Processs(EntityParent theOwner)
        {
            return false;
        }
    }

    /// <summary>
    /// 顺序结点，只要一个返回false,就返回false
    /// </summary>
    public class SequenceNode : CompositeNode
    {
        public override bool Processs(Entity.EntityParent theOwner)
        {
            foreach(IBTreeNode node in mChildren)
            {
                if(node != null)
                {
                    if(!node.Processs(theOwner))
                    {
                        return false;
                    }
                }
                else
                    return false;
            }

            return true;
        }
    }

    /// <summary>
    /// 选择结点，只要有一个true,就返回true
    /// </summary>
    public class SelectorNode : CompositeNode
    {
        public override bool Processs(Entity.EntityParent theOwner)
        {
            //return base.Processs(theOwner);
            foreach(IBTreeNode node in mChildren)
            {
                if(node != null)
                {
                    if(node.Processs(theOwner))
                    {
                        return true;
                    }
                }
            }

            return false;
        }
    }

    /// <summary>
    /// 执行所有节点，按设定值返回false,true
    /// </summary>
    public class ParallelNode : CompositeNode
    {
        bool mbReturn = false;

        public ParallelNode(bool bReturn)
        {
            mbReturn = bReturn;
        }

        public override bool Processs(Entity.EntityParent theOwner)
        {
            foreach(IBTreeNode node in mChildren)
            {
                if(node != null)
                {
                    node.Processs(theOwner);
                }
            }

            return mbReturn;
        }
    }
}
