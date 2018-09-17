//
//  AlgorithmsViewController.m
//  MyProjectModule
//
//  Created by Zhang Xin Xin on 2018/9/17.
//  Copyright © 2018年 xinxin. All rights reserved.
//

#import "AlgorithmsViewController.h"

@interface AlgorithmsViewController ()

@end

@implementation AlgorithmsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doSomeThings];
}


-(void)doSomeThings{
    
    // 测试数据
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@8, @5, @9, @2, @5, @7, nil];
    
    NSMutableArray *bubbArray = [self BubbleSortOC:array];
    //    NSLog(@"%@",bubbArray);
    
    NSMutableArray *insertArray = [self InsertSortOC:array];
    //    NSLog(@"%@",insertArray);
    
    NSMutableArray *selectArray = [self SelectionSortOC:array];
    //    NSLog(@"%@",selectArray);
    
    NSMutableArray *quickArray = [self QuickSorkOC:array Count:array.count];
    //    NSLog(@"%@",quickArray);
    
    NSInteger binary = [self BinarySearch:@[@"2",@"5",@"6",@"8",@"9"] target:@"9"];
    NSLog(@"%ld",binary);

    
}

#pragma mark - 冒泡排序
/**
 
 1. 首先将所有待排序的数字放入工作列表中。
 
 2. 从列表的第一个数字到倒数第二个数字，逐个检查：若某一位上的数字大于他的下一位，则将它与它的下一位交换。
 
 3. 重复2号步骤(倒数的数字加1。例如：第一次到倒数第二个数字，第二次到倒数第三个数字，依此类推...)，直至再也不能交换。
 
 平均时间复杂度：O(n^2)
 
 平均空间复杂度：O(1)
 
 */
- (NSMutableArray *)BubbleSortOC:(NSArray *)array
{
    
    id temp;
    
    int i, j;
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    
    for (i=0; i < [arr count] - 1; ++i) {
        
        for (j=0; j < [arr count] - i - 1; ++j) {
            
            if (arr[j] > arr[j+1]) {    // 升序排列
                
                temp = arr[j];
                
                arr[j] = arr[j+1];
                
                arr[j+1] = temp;
                
            }
            
        }
        
    }
    
    return arr;
}

#pragma mark - 插入排序
/**
 
 1. 从第一个元素开始，认为该元素已经是排好序的。
 
 2. 取下一个元素，在已经排好序的元素序列中从后向前扫描。
 
 3. 如果已经排好序的序列中元素大于新元素，则将该元素往右移动一个位置。
 
 4. 重复步骤3，直到已排好序的元素小于或等于新元素。
 
 5. 在当前位置插入新元素。
 
 6. 重复步骤2。
 
 
 
 平均时间复杂度：O(n^2)
 
 平均空间复杂度：O(1)
 
 */
- (NSMutableArray *)InsertSortOC:(NSArray *)array
{
    
    id temp;
    
    int i, j;
    
    
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    
    for (i=1; i < [arr count]; ++i) {
        
        temp = arr[i];
        
        for (j=i; j > 0 && temp < arr[j-1]; --j) {
            
            arr[j] = arr[j-1];
            
        }
        
        arr[j] = temp;      // j是循环结束后的值
        
    }
    
    
    
    return arr;
}

#pragma mark - 选择排序
/**
 
 1. 设数组内存放了n个待排数字，数组下标从1开始，到n结束。
 
 2. i=1
 
 3. 从数组的第i个元素开始到第n个元素，寻找最小的元素。（具体过程为:先设arr[i]为最小，逐一比较，若遇到比之小的则交换）
 
 4. 将上一步找到的最小元素和第i位元素交换。
 
 5. 如果i=n－1算法结束，否则回到第3步
 
 
 
 平均时间复杂度：O(n^2)
 
 平均空间复杂度：O(1)
 
 */
- (NSMutableArray *)SelectionSortOC:(NSArray *)array
{
    
    id temp;
    
    int min, i, j;
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    
    for (i=0; i < [arr count]; ++i) {
        
        min = i;
        
        for (j = i+1; j < [arr count]; ++j) {
            
            if (arr[min] > arr[j]) {
                
                min = j;
                
            }
            
        }
        
        if (min != i) {
            
            temp = arr[min];
            
            arr[min] = arr[i];
            
            arr[i] = temp;
            
        }
        
    }
    
    
    
    return arr;
}

#pragma mark - 快速排序
/**
 
 1. 从数列中挑出一个元素，称为 "基准"（pivot），
 
 2. 重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以到任一边）。在这个分割之后，该基准是它的最后位置。这个称为分割（partition）操作。
 
 3. 递归地（recursive）把小于基准值元素的子数列和大于基准值元素的子数列排序。
 
 递回的最底部情形，是数列的大小是零或一，也就是永远都已经被排序好了。虽然一直递回下去，但是这个算法总会结束，因为在每次的迭代（iteration）中，它至少会把一个元素摆到它最后的位置去。
 
 
 
 平均时间复杂度：O(n^2)
 
 平均空间复杂度：O(nlogn)       O(nlogn)~O(n^2)
 
 */

- (NSMutableArray *)QuickSorkOC:(NSMutableArray *)array Count:(NSInteger)count
{
    
    NSInteger i = 0;
    
    NSInteger j = count - 1;
    
    id pt = array[0];
    
    
    
    if (count > 1) {
        
        while (i < j) {
            
            for (; j > i; --j) {
                
                if (array[j] < pt) {
                    
                    array[i++] = array[j];
                    
                    break;
                    
                }
                
            }
            
            for (; i < j; ++i) {
                
                if (array[i] > pt) {
                    
                    array[j--] = array[i];
                    
                    break;
                    
                }
                
            }
            
            array[i] = pt;
            
            [self QuickSorkOC:array Count:i];
            
            [self QuickSorkOC:array Count:count - i - 1];
            
        }
        
    }
    
    return array;
}

#pragma mark - 二分查找法
/**
 *  当数据量很大适宜采用该方法。
 
 采用二分法查找时，数据需是排好序的。
 
 基本思想：假设数据是按升序排序的，对于给定值x，从序列的中间位置开始比较，如果当前位置值等于x，则查找成功；若x小于当前位置值，则在数列的前半段 中查找；若x大于当前位置值则在数列的后半段中继续查找，直到找到为止。
 
 */
- (NSInteger)BinarySearch:(NSArray *)array target:(id)key
{
    
    NSInteger left = 0;
    
    NSInteger right = [array count] - 1;
    
    NSInteger middle = [array count] / 2;
    
    
    
    while (right >= left) {
        
        middle = (right + left) / 2;
        
        
        
        if (array[middle] == key) {
            
            return middle;
            
        }
        
        if (array[middle] > key) {
            
            right = middle - 1;
            
        }
        
        else if (array[middle] < key) {
            
            left = middle + 1;
            
        }
        
    }
    
    return -1;
}

@end
