//
//  main.c
//  c_test
//
//  Created by OA Wu on 2015/4/28.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct users {
    char name[4];
    int age;
    char address[30];
} User;


int main(int argc, const char * argv[]) {
    // insert code here...
//    int* a;
//    a = malloc(sizeof (int));
//    *a = 4;
//    
//    printf("空間儲存值：%d", *a);
//
    
//    User user;
//    strcpy (user.name, "aaa");
//    printf("%s", user.name);
    User* user = malloc(sizeof(User));
    strcpy(user->name, "aaa");
    printf("%s", (*user).name);
    
    return 0;
}
