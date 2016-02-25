/********************************************************************
    created:    2016/02/25
    created:    2016/2/25  21:00
    filename:   BTree.h
    author:     郑辉

    purpose:    行为树根结点
*********************************************************************/
#ifndef _BTREE_H_
#define _BTREE_H_

#include <vector>
#include "../Entity/Entity.h"

namespace NF_BT
{
    class IBTreeNode
    {
    public:
        virtual bool Process(EntityParent*theOwner) = 0;
    };

    //跟结点
    class  BTreeRoot : public IBTreeNode
    {
    public:
        BTreeRoot();
        ~BTreeRoot();

        virtual bool Process(EntityParent * theOwner);

        virtual void SetRoot(IBTreeNode *pRoot);
    private:
        IBTreeNode * mRoot;
    };

    //复合结点
    class  CompositionNode: public IBTreeNode
    {
    public:
        CompositionNode();
        ~CompositionNode();


        virtual bool Process(EntityParent*theOwner);

        virtual void AddChild(IBTreeNode *pNode);
        virtual void DelChild(IBTreeNode *pNode);
        virtual void CleanAll();
    protected:
        std::vector<IBTreeNode*> mChildren;
    };

    //decorator装饰结点
    class DecoratorNode : public IBTreeNode
    {
    public:
        DecoratorNode();
        ~DecoratorNode();

        virtual bool Process(EntityParent*theOwner);

        virtual void SetNode(IBTreeNode *pNode);
    protected:
        IBTreeNode * m_pNode;
    };

    //condition结点
    class ConditionNode : public IBTreeNode
    {
    public:
        virtual bool Process(EntityParent*theOwner);
    };

    //action结点
    class  ActionNode : public IBTreeNode
    {
    public:
        virtual bool Process(EntityParent*theOwner);
    };

    //////////////////////////////////////////////////////////////////////////
    //复合结点
    class  SequenceNode : public CompositionNode
    {
    public:
        virtual bool Process(EntityParent*theOwner);
    };

    class SelectorNode : public CompositionNode
    {
    public:
        virtual bool Process(EntityParent*theOwner);
    };

    //并行结点
    class  ParallelNode : public CompositionNode
    {
    public:
        ParallelNode(bool bReturn);
        ~ParallelNode();

        virtual bool Process(EntityParent*theOwner);
    private:
        bool mReturn;
    };
}

//////////////////////////////////////////////////////////////////////////
#endif // !_BTREE_H_

