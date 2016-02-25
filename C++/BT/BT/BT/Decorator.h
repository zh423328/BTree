/********************************************************************
    created:    2016/02/25
    created:    2016/2/25  22:19
    filename:   Decorator.h
    author:     ÷£ª‘

    purpose:    ◊∞ Œ¿‡ Not Success
*********************************************************************/
#ifndef DECORATORNODE_H_
#define DECORATORNODE_H_

#include "BTree.h"

namespace NF_BT
{
    class  NotNode : public DecoratorNode
    {
    public:
        virtual bool Process(EntityParent*theOwner);
    };

    class  SuccessNode : public DecoratorNode
    {
    public:
        virtual bool Process(EntityParent*theOwner);
    };
}
#endif
