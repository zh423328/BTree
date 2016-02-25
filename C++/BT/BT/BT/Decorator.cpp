/********************************************************************
    created:    2016/02/25
    created:    2016/2/25  22:21
    filename:   Decorator.cpp
    author:     Ö£»Ô

    purpose:    ×°ÊÎÀà
*********************************************************************/
#include "Decorator.h"

namespace NF_BT
{
    bool NotNode::Process(EntityParent*theOwner)
    {
        if(m_pNode)
        {
            return !m_pNode->Process(theOwner);
        }

        return false;
    }


    bool SuccessNode::Process(EntityParent*theOwner)
    {
        if(m_pNode)
        {
            return m_pNode->Process(theOwner);
        }

        return false;
    }

}