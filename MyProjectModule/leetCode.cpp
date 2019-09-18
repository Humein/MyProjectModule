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

// 141. 环形链表
class SolutionhasCycle {
public:
    bool hasCycle(ListNode *head) {
        ListNode *fast = head, *slow = head;
        while (fast && fast->next) {
            fast = fast->next->next;
            slow = slow->next;
            if (slow == fast) {
                return true;
            }
        }

        return false;
    }
};

// 142. 环形链表 II
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
    
    ListNode *detectCycles(ListNode *head){
        ListNode *fast = head, *slow = head;
        
        while (fast && fast->next) {
            fast = fast->next->next;
            slow = slow->next;
            if (slow == fast) {
                break;
            }
        }
        
        fast = head;
        
        while (fast != slow) {
            fast = fast->next;
            slow = slow->next;
        }
        
        return fast;
        
    }
    
};

