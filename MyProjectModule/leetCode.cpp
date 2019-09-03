//
//  leetCode.cpp
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2019/8/28.
//  Copyright © 2019 xinxin. All rights reserved.
//

#include "leetCode.hpp"

struct ListNode {
       int val;
       ListNode *next;
       ListNode(int x) : val(x), next(NULL) {}
};

class Solution {
    
public:
    
    ListNode *detectCycle(ListNode *head) {
        ListNode *fast = head, *slow = head;
        
        while (fast && fast->next) {
            fast = fast->next->next;
            slow = slow->next;
            if (fast == slow) {
                break;
            }
        }
        
        if (!fast || !fast->next) {
            return NULL;
        }
        
        fast = head;
        
        while (fast != slow) {
            fast = fast->next;
            slow = slow->next;
        }
        
        return fast;
    }
    
};
