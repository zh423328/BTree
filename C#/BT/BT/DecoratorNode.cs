/********************************************************************
    created:    2016/02/25
    created:    2016/2/25  20:46
    filename:   Decorator.cs
    author:     郑辉

    purpose:    装饰结点,就是为仅有的一个子节点额外添加一些功能，比如让子task一直运行直到其返回某个运行状态值，或者将task的返回值取反等等
 *  如DecoratorNode等
*********************************************************************/
using System;
using System.Collections.Generic;
using System.Linq;

namespace NF.BT
{
    /// <summary>
    /// 返回非
    /// </summary>
    public class Not : DecoratorNode
    {
        public override bool Processs(Entity.EntityParent theOwner)
        {
            return !base.Processs(theOwner);
        }
    }

    /// <summary>
    /// 直到返回true
    /// </summary>
    public class Success : DecoratorNode
    {
        public override bool Processs(Entity.EntityParent theOwner)
        {
            return base.Processs(theOwner);
        }
    }

}
