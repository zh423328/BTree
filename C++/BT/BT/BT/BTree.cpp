/********************************************************************
    created:    2016/02/25
    created:    2016/2/25  21:19
    filename:   BTree.cpp
    author:     郑辉

    purpose:    行为树基类
*********************************************************************/
#include "BTree.h"

#define SAFE_DELETE(p) if (p){ delete p; p = NULL;}

namespace NF_BT
{
    BTreeRoot::BTreeRoot()
    {
        mRoot = NULL;
    }

    BTreeRoot::~BTreeRoot()
    {
        SAFE_DELETE(mRoot);
    }

    bool BTreeRoot::Process(EntityParent * theOwner)
    {
        if(mRoot)
        {
            return mRoot->Process(theOwner);
        }

        return false;
    }

    void BTreeRoot::SetRoot(IBTreeNode *pRoot)
    {
        mRoot = pRoot;
    }

    CompositionNode::CompositionNode()
    {
    }

    CompositionNode::~CompositionNode()
    {
        CleanAll();
    }

    bool CompositionNode::Process(EntityParent*theOwner)
    {
        return false;
    }

    void CompositionNode::AddChild(IBTreeNode *pNode)
    {
        mChildren.push_back(pNode);
    }

    void CompositionNode::DelChild(IBTreeNode *pNode)
    {
        for(int i = 0; i < mChildren.size(); ++i)
        {
            IBTreeNode *node = mChildren[i];

            if(node == pNode)
            {
                mChildren.erase(mChildren.begin() + i);
                break;
            }
        }
    }

    void CompositionNode::CleanAll()
    {
        for(int i = 0; i < mChildren.size(); ++i)
        {
            SAFE_DELETE(mChildren[i]);
        }

        mChildren.clear();
    }

    //////////////////////////////////////////////////////////////////////////
    DecoratorNode::DecoratorNode()
    {
    }
    DecoratorNode::~DecoratorNode()
    {
        SAFE_DELETE(m_pNode);
    }

    bool DecoratorNode::Process(EntityParent*theOwner)
    {
        if(m_pNode)
        {
            return m_pNode->Process(theOwner);
        }

        return false;
    }

    void DecoratorNode::SetNode(IBTreeNode *pNode)
    {
        m_pNode = pNode;
    }
    //////////////////////////////////////////////////////////////////////////

    //////////////////////////////////////////////////////////////////////////

    bool ConditionNode::Process(EntityParent*theOwner)
    {
        return false;
    }

    //////////////////////////////////////////////////////////////////////////

    bool ActionNode::Process(EntityParent*theOwner)
    {
        return false;
    }

    //////////////////////////////////////////////////////////////////////////

    bool SequenceNode::Process(EntityParent*theOwner)
    {
        for(int  i = 0; i < mChildren.size(); ++i)
        {
            IBTreeNode *pNode = mChildren[i];

            if(pNode != NULL)
            {
                if(!pNode->Process(theOwner))
                {
                    return false;
                }
            }
        }

        return true;
    }

    bool SelectorNode::Process(EntityParent*theOwner)
    {
        for(int  i = 0; i < mChildren.size(); ++i)
        {
            IBTreeNode *pNode = mChildren[i];

            if(pNode != NULL)
            {
                if(pNode->Process(theOwner))
                {
                    return true;
                }
            }
        }

        return false;
    }

    ParallelNode::ParallelNode(bool bReturn)
    {
        mReturn = bReturn;
    }

    ParallelNode::~ParallelNode()
    {
    }

    bool ParallelNode::Process(EntityParent*theOwner)
    {
        for(int i = 0; i < mChildren.size(); ++i)
        {
            IBTreeNode *pNode = mChildren[i];

            if(pNode)
            {
                pNode->Process(theOwner);
            }
        }

        return mReturn;
    }

}
